use std::{cell::RefCell, rc::Rc};

use clingo::ClingoError;
use nom_locate::LocatedSpan;

use crate::{Lit, Task};

#[derive(thiserror::Error, Debug)]
pub enum IlnlpError {
    #[error("Incompatible for condition (i)")]
    IncompatibleOne,
    #[error("Incompatible for condition (ii)")]
    IncompatibleTwo,
    #[error("Incompatible for condition (iii)")]
    IncompatibleThree,
    #[error("Clingo error: {0}")]
    Clingo(#[from] ClingoError),
    #[error("No model found")]
    NoModel,
    #[error("Invalid literal: {0}")]
    InvalidLit(Lit),
    #[error("{0}")]
    ParserError(String),
    #[error("{0}")]
    TeraError(#[from]tera::Error),
}

impl From<nom::Err<nom::error::Error<LocatedSpan<&str, Rc<RefCell<Task>>>>>> for IlnlpError {
    fn from(value: nom::Err<nom::error::Error<LocatedSpan<&str, Rc<RefCell<Task>>>>>) -> Self {
        match value {
            nom::Err::Error(e) | nom::Err::Failure(e) => IlnlpError::ParserError(format!(
                "Parse error at line {}, column {}: {:?}",
                e.input.location_line(),
                e.input.get_utf8_column(),
                e.code
            )),
            nom::Err::Incomplete(_) => {
                IlnlpError::ParserError("Unexpected end of input".to_string())
            }
        }
    }
}
