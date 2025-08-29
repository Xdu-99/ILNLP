pub mod asp;
pub mod error;
pub mod ilasp;
pub mod parser;
pub mod set;
pub mod stat;

use crate::error::IlnlpError;
use crate::ilasp::{ILTask, ILTaskBuilder};
use crate::set::Set;
use crate::stat::Stat; 
use itertools::Itertools;
use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
use std::rc::Rc;
use std::sync::{Arc, Mutex}; 

pub type Lit = usize;
pub type LitSet = Set<Lit>;

#[derive(Debug, Default)]
pub struct LitBuilder {
    literals: Rc<RefCell<Vec<Rc<Literal>>>>,
    lits_id_map: Rc<RefCell<HashMap<Rc<Literal>, usize>>>,
}

impl LitBuilder {
    pub fn create_literal(&self, literal: Literal) -> Lit {
        let literal = Rc::new(literal);
        let mut lits_id_map = self.lits_id_map.borrow_mut();
        let mut literals = self.literals.borrow_mut();
        match lits_id_map.get(&literal) {
            Some(id) => *id,
            None => {
                literals.push(literal.clone());
                let id = literals.len();
                lits_id_map.insert(literal, id);
                id
            }
        }
    }

    pub fn get_literal(&self, lit: Lit) -> Result<Rc<Literal>, IlnlpError> {
        let literals = self.literals.borrow();
        literals
            .get(lit - 1)
            .ok_or(IlnlpError::InvalidLit(lit))
            .map(|c| c.clone())
    }

    pub fn get_literals(&self, iter: std::slice::Iter<Lit>) -> Vec<Rc<Literal>> {
        let literals = self.literals.borrow();
        iter.filter(|x| **x < literals.len() + 1 && **x > 0)
            .map(|x| unsafe { Rc::clone(literals.get_unchecked(x - 1)) })
            .collect()
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, serde::Serialize)]
pub struct Literal {
    pub predicate: String,
    pub args: Vec<String>,
}

impl Literal {
    pub fn new(predicate: String, args: Vec<String>) -> Self {
        Literal { predicate, args }
    }
}

impl std::fmt::Display for Literal {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        if self.args.is_empty() {
            write!(f, "{}", self.predicate)
        } else {
            write!(f, "{}({})", self.predicate, self.args.join(", "))
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Comparison {
    NotEqual(String, String),
    Greater(String, String),
    Less(String, String),
}

impl std::fmt::Display for Comparison {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match self {
            Comparison::NotEqual(left, right) => write!(f, "{} != {}", left, right),
            Comparison::Greater(left, right) => write!(f, "{} > {}", left, right),
            Comparison::Less(left, right) => write!(f, "{} < {}", left, right),
        }
    }
}

#[derive(Debug, Clone)]
pub struct Rule {
    pub head: Option<Literal>,
    pub body: Vec<BodyLiteral>,
}

impl std::fmt::Display for Rule {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let head = self
            .head
            .as_ref()
            .map(|h| h.to_string())
            .unwrap_or_default();
        if self.body.is_empty() {
            write!(f, "{}.", head)
        } else {
            let body = self
                .body
                .iter()
                .map(|b| b.to_string())
                .collect::<Vec<_>>()
                .join(", ");
            write!(f, "{} :- {}.", head, body)
        }
    }
}

#[derive(Debug, Clone)]
pub enum BodyLiteral {
    Literal { literal: Literal, negated: bool },
    Comparison(Comparison),
}

impl ToString for BodyLiteral {
    fn to_string(&self) -> String {
        match self {
            BodyLiteral::Literal { literal, negated } => {
                if *negated {
                    format!("not {}", literal)
                } else {
                    literal.to_string()
                }
            }
            BodyLiteral::Comparison(comp) => comp.to_string(),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Example {
    pub input: LitSet,
    pub output: Vec<LitSet>,
}

impl Example {
    fn compute_neg_example(
        &self,
        global_literals: &LitSet,
        literals: &LitSet,
        iltask: &mut ILTaskBuilder<Rc<Literal>, Rule>,
        builder: &LitBuilder,
    ) -> Result<(), IlnlpError> {
        let input = &self.input;
        let output = &self.output;

        for a in global_literals.difference(literals).iter() {
            iltask.push_neg_example(
                vec![builder.get_literal(*a)?],
                vec![],
                builder.get_literals(input.iter()),
            );
        }

        let less_out = output
            .iter()
            .map(|x| x.difference(input))
            .collect::<Vec<_>>();
        let elements = literals.difference(input);

        let mut m = (1..elements.len())
            .map(|i| elements.iter().cloned().combinations(i))
            .flatten()
            .map(|x| LitSet::new(x))
            .filter(|a| {
                !less_out
                    .iter()
                    .any(|o: &LitSet| o.is_subset(a) || o.is_superset(a))
            })
            .sorted_by(|a, b| a.len().cmp(&b.len()))
            .collect::<Vec<_>>();

        while !m.is_empty() {
            let a = m.remove(0);
            let (mut superset, new_m): (Vec<_>, Vec<_>) = m.into_iter().partition(|x| a.is_subset(x));
            m = new_m;
            if superset.is_empty() {
                superset.push(a.clone());
            }
            let mut last_len = 0;
            for b in superset.iter().rev() {
                if b.len() < last_len {
                    break;
                }
                last_len = b.len();
                iltask.push_neg_example(
                    builder.get_literals(a.union(input).iter()),
                    builder.get_literals(global_literals.difference(&input.union(b)).iter()),
                    builder.get_literals(input.iter()),
                );
            }
        }

        Ok(())
    }

    pub fn compute_example(
        &self,
        global_literals: &LitSet,
        iltask: &mut ILTaskBuilder<Rc<Literal>, Rule>,
        builder: &LitBuilder,
    ) -> Result<(), IlnlpError> {
        let output = self.output.iter().collect::<Vec<_>>();
        let literals = output.iter().fold(Vec::default(), |mut acc, x| {
            acc.extend(x.iter().cloned());
            acc
        });
        let literals = LitSet::new(literals);
        let input = &self.input;
        let input_literals = builder.get_literals(input.iter());

        if self.output.is_empty() {
            iltask.push_neg_example(vec![], vec![], input_literals.clone());
        } else {
            for s in output {
                iltask.push_pos_example(
                    builder.get_literals(s.iter()),
                    builder.get_literals(global_literals.difference(s).iter()),
                    input_literals.clone(),
                );
            }
            self.compute_neg_example(global_literals, &literals, iltask, builder)?;
        }

        let less_out = builder.get_literals(literals.difference(input).iter());
        less_out.into_iter().for_each(|lit| {
            iltask.push_head(lit.clone());
            iltask.push_general_body(lit);
        });
        input_literals.into_iter().for_each(|lit| {
            iltask.push_positive_body(lit);
        });

        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct Task {
    background: Vec<Rule>,
    examples: Vec<Example>,
    lit_builder: LitBuilder,
}

impl Task {
    pub fn create_literal(&self, literal: Literal) -> Lit {
        self.lit_builder.create_literal(literal)
    }

    pub fn get_literal(&self, lit: Lit) -> Result<Rc<Literal>, IlnlpError> {
        self.lit_builder.get_literal(lit)
    }

    pub fn push_example(&mut self, example: Example) {
        self.examples.push(example);
    }

    pub fn push_background(&mut self, rule: Rule) {
        self.background.push(rule);
    }

    fn get_definite_rules(&self) -> Vec<&Rule> {
        self.background
            .iter()
            .filter(|rule| {
                rule.body.iter().all(|literal| {
                    if let BodyLiteral::Literal { negated, .. } = literal {
                        !negated
                    } else {
                        true
                    }
                })
            })
            .collect()
    }

    fn compute_universe(&self) -> Result<LitSet, IlnlpError> {
        let mut universe = Vec::new();
        for example in &self.examples {
            for output in &example.output {
                asp::ground_literals(
                    &self.background,
                    &example.input,
                    output,
                    &self.lit_builder,
                    &mut universe,
                )?;
            }
        }
        Ok(LitSet::new(universe))
    }

    // 新增：计算 universe 统计信息
    pub fn compute_universe_stats(&self) -> Result<(usize, usize), IlnlpError> {
        let universe = self.compute_universe()?;
        let literals = self.lit_builder.get_literals(universe.iter());
        let size = literals.len();
        let unique_predicates = literals
            .iter()
            .map(|lit| lit.predicate.clone())
            .collect::<HashSet<_>>()
            .len();
        Ok((size, unique_predicates))
    }

    pub fn check_compatibility(&mut self) -> Result<(), IlnlpError> {
        if self.examples.len() < 2 {
            return Ok(());
        }
        let definite = self.get_definite_rules();
        let examples = self.examples.iter();
        let lit_builder = &self.lit_builder;
        for e in examples.combinations(2) {
            let e1 = unsafe { e.get_unchecked(0) };
            let e2 = unsafe { e.get_unchecked(1) };
            let o1 = e1.output.iter().collect::<HashSet<_>>();
            let o2 = e2.output.iter().collect::<HashSet<_>>();
            for s1 in o1.difference(&o2) {
                if e2.input.is_subset(s1) {
                    for s2 in &e2.output {
                        if e1.input.is_subset(s2)
                            && ((s1.is_subset(s2)) || (s2.is_subset(s1)) && s1.len() != s2.len())
                        {
                            return Err(IlnlpError::IncompatibleOne);
                        }
                    }
                    let least_model = asp::compute_models(&definite, &e2.input, lit_builder, 1)?;
                    if e1.input.is_subset(least_model.get(0).unwrap()) {
                        return Err(IlnlpError::IncompatibleTwo);
                    }
                    let answer_sets = asp::compute_models(&definite, &e2.input, lit_builder, 1)?;
                    for m in &answer_sets {
                        if e1.input.is_subset(m) {
                            return Err(IlnlpError::IncompatibleThree);
                        }
                    }
                }
            }
        }
        Ok(())
    }

    pub fn ilas(&mut self, stat: Arc<Mutex<Stat>>) -> anyhow::Result<ILTask<Rc<Literal>, Rule>> {
        let mut iltask = ILTaskBuilder::default();
        self.background.iter().for_each(|r| {
            iltask.push_background(r.clone());
        });
        let global_literals = self.compute_universe()?;
        // 记录 universe 统计信息
        let (universe_size, unique_predicates) = self.compute_universe_stats()?;
        stat.lock().unwrap().record_universe_stats(universe_size, unique_predicates);
        for e in self.examples.iter() {
            e.compute_example(&global_literals, &mut iltask, &self.lit_builder)?;
        }
        Ok(iltask.build())
    }
}