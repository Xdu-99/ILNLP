
use clingo::{Part, ShowType, SolveMode};

use crate::{Lit, Literal, Rule, LitSet, error::IlnlpError};

/// compute models for a given set of rules and facts 

pub fn compute_models(
    rules: &[&Rule],
    facts: &LitSet,
    builder: & crate::LitBuilder,
    limit: usize,
) -> Result<Vec<LitSet>, IlnlpError> {
    let mut ctl = clingo::control(vec![])?;
    let mut program = String::new();
    let mut models = Vec::new();
    rules.iter().for_each(|rule| {
        program.push_str(&rule.to_string());
        program.push('\n');
    });
    for lit in facts.iter() {
        let l = builder.get_literal(*lit)?;
        program.push_str(&l.to_string());
        program.push('.');
        program.push('\n');
    }
    ctl.add("base", &[], &program)?;
    let part = Part::new("base", vec![])?;
    let parts = vec![part];
    ctl.ground(&parts)?;
    // get a solve handle
    let mut handle = ctl.solve(SolveMode::YIELD, &[])?;

    // loop over all models
    // let mut  m:&Model;
    for _i in 0..limit {
        handle.resume()?;
        let model = match handle.model()? {
            Some(m) => m,
            None => break,
        };

        let atoms = model
            .symbols(ShowType::SHOWN)?
            .iter()
            .map(|s| {
                let name = s.name().unwrap();
                let d: Vec<String> = s
                    .arguments()
                    .unwrap()
                    .iter()
                    .map(|x| x.to_string())
                    .collect();
                builder.create_literal(Literal::new(name.to_string(), d))
            })
            .collect::<_>();
        models.push(LitSet::new(atoms));
    }

    // close the solve handle
    handle.close()?;
    if models.is_empty() {
        Err(IlnlpError::NoModel)
    } else {
        Ok(models)
    }
}

pub fn ground_literals(
    rules: &[Rule],
    facts1: &LitSet,
    facts2: &LitSet,
    builder: & crate::LitBuilder,

    result: &mut Vec<Lit>,
) -> Result<(), IlnlpError> {
    let mut ctl = clingo::control(vec![])?;
    let mut program = String::new();
    rules.iter().for_each(|rule| {
        program.push_str(&rule.to_string());
        program.push('\n');
    });
    for lit in facts1.iter() {
        let l = builder.get_literal(*lit)?;
        program.push_str(&l.to_string());
        program.push('.');
        program.push('\n');
    }
    for lit in facts2.iter() {
        let l = builder.get_literal(*lit)?;
        program.push_str(&l.to_string());
        program.push('.');
        program.push('\n');
    }
    ctl.add("base", &[], &program)?;
    let part = Part::new("base", vec![])?;
    let parts = vec![part];
    ctl.ground(&parts)?;

    let atoms = ctl.symbolic_atoms()?;
    for atom in atoms.iter()? {
        if atom.is_fact()? {
            let s = atom.symbol()?;
            let name = s.name().unwrap();
            let d: Vec<String> = s
                .arguments()
                .unwrap()
                .iter()
                .map(|x| x.to_string())
                .collect();
            result
                .push(builder.create_literal(Literal::new(name.to_string(), d)));
        }
    }
    Ok(())
}
