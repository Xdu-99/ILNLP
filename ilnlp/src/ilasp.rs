use std::fmt::Debug;

use serde::ser::SerializeMap;

use crate::error::IlnlpError;

macro_rules! serialize_seq_field {
    ($map:expr, $field:expr, $key:expr) => {{
        let strs: Vec<String> = $field.iter().map(|x| x.to_string()).collect();
        $map.serialize_entry($key, &strs)?;
    }};
}

#[derive(Debug)]
pub struct ILSearchSpace<T> {
    positive_body: Vec<T>,
    general_body: Vec<T>,
    head: Vec<T>,
}

impl<T> Default for ILSearchSpace<T> {
    fn default() -> Self {
        Self {
            positive_body: Default::default(),
            general_body: Default::default(),
            head: Default::default(),
        }
    }
}

impl<T: Ord> ILSearchSpace<T> {
    fn rebuild(&mut self) {
        self.positive_body.sort();
        self.positive_body.dedup();
        self.general_body.sort();
        self.general_body.dedup();
        self.head.sort();
        self.head.dedup();
    }
}
impl<T: ToString> serde::ser::Serialize for ILSearchSpace<T> {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: serde::Serializer,
    {
        let mut map = serializer.serialize_map(Some(3))?;
        serialize_seq_field!(map, self.positive_body, "positive_body");
        serialize_seq_field!(map, self.general_body, "general_body");
        serialize_seq_field!(map, self.head, "head");
        map.end()
    }
}

#[derive(Debug)]
pub struct ILTaskBuilder<T: Debug, R: Debug> {
    pos_examples: Vec<ILExample<T>>,
    neg_examples: Vec<ILExample<T>>,
    search_space: ILSearchSpace<T>,
    background: Vec<R>,
}

impl<T: Debug, R: Debug> Default for ILTaskBuilder<T, R> {
    fn default() -> Self {
        Self {
            pos_examples: Default::default(),
            neg_examples: Default::default(),
            search_space: Default::default(),
            background: Default::default(),
        }
    }
}

impl<T, R> ILTaskBuilder<T, R>
where
    T: Debug + Ord,
    R: Debug,
{
    pub fn push_pos_example(&mut self, incl: Vec<T>, excl: Vec<T>, ctx: Vec<T>) {
        self.pos_examples.push(ILExample::new(incl, excl, ctx));
    }

    pub fn push_neg_example(&mut self, incl: Vec<T>, excl: Vec<T>, ctx: Vec<T>) {
        self.neg_examples.push(ILExample::new(incl, excl, ctx));
    }
    pub fn push_background(&mut self, r: R) {
        self.background.push(r);
    }
    pub fn push_positive_body(&mut self, r: T) {
        self.search_space.positive_body.push(r);
    }
    pub fn push_general_body(&mut self, r: T) {
        self.search_space.general_body.push(r);
    }
    pub fn push_head(&mut self, r: T) {
        self.search_space.head.push(r);
    }

    pub fn build(mut self) -> ILTask<T, R> {
        self.neg_examples.sort();
        self.neg_examples.dedup();
        self.pos_examples.sort();
        self.pos_examples.dedup();
        self.search_space.rebuild();
        ILTask {
            pos_examples: self.pos_examples,
            neg_examples: self.neg_examples,
            search_space: self.search_space,
            background: self.background,
        }
    }
}

#[derive(Debug, Default, PartialEq, Eq, PartialOrd, Ord)]
pub struct ILExample<T> {
    incl: Vec<T>,
    excl: Vec<T>,
    ctx: Vec<T>,
}

impl<T: ToString> serde::ser::Serialize for ILExample<T> {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: serde::Serializer,
    {
        let mut map = serializer.serialize_map(Some(3))?;
        serialize_seq_field!(map, self.incl, "incl");
        serialize_seq_field!(map, self.excl, "excl");
        serialize_seq_field!(map, self.ctx, "ctx");

        map.end()
    }
}

impl<T> ILExample<T> {
    pub fn new(incl: Vec<T>, excl: Vec<T>, ctx: Vec<T>) -> ILExample<T> {
        ILExample { incl, excl, ctx }
    }
}

#[derive(Debug, Default)]
pub struct ILTask<T, R> {
    pos_examples: Vec<ILExample<T>>,
    neg_examples: Vec<ILExample<T>>,
    search_space: ILSearchSpace<T>,
    background: Vec<R>,
}

impl<T: ToString, R: ToString> serde::ser::Serialize for ILTask<T, R> {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: serde::Serializer,
    {
        let mut map = serializer.serialize_map(Some(4))?;
        map.serialize_entry("pos_examples", &self.pos_examples)?;
        map.serialize_entry("neg_examples", &self.neg_examples)?;
        map.serialize_entry("search_space", &self.search_space)?;
        serialize_seq_field!(map, self.background, "background");
        map.end()
    }
}

impl<T: ToString, R: ToString> ILTask<T, R> {
    pub fn to_progam_with_template(&self, templete: &str) -> Result<String, IlnlpError> {
        let mut tera = tera::Tera::default();
        tera.add_raw_template("ilasp", templete).unwrap();
        let context = tera::Context::from_serialize(&self)?;

        let rendered = tera.render("ilasp", &context)?;
        Ok(rendered)
    }
    pub fn to_progam(&self) -> Result<String, IlnlpError> {
        self.to_progam_with_template(include_str!("../templates/defalut.tpl"))
    }
}
