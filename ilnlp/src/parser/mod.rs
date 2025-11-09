use std::{cell::RefCell, rc::Rc};

use nom::{
    IResult, Parser,
    branch::alt,
    bytes::complete::{tag, take_while},
    character::complete::{digit1, multispace0, multispace1, one_of},
    combinator::{map, opt, recognize},
    multi::{many0, separated_list0, separated_list1},
    sequence::{delimited, preceded},
};
use nom_locate::LocatedSpan;

use crate::{
    BodyLiteral, Comparison, Example, Lit, LitSet, Literal, Rule, Task, error::IlnlpError,
};

type Span<'a> = LocatedSpan<&'a str, Rc<RefCell<Task>>>;

fn parse_variable(input: Span) -> IResult<Span, String> {
    let identifier = recognize((
        take_while(|c: char| c == '_'),
        one_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ"),
        take_while(|c: char| {
            c.is_ascii_alphanumeric() || c == '_' || c == '+' || c == '-' || c == '\''
        }),
    ));

    map(identifier, |s: Span| s.to_string()).parse(input)
}
fn parse_integer(input: Span) -> IResult<Span, String> {
    map(digit1, |s: Span| s.to_string()).parse(input)
}
fn parse_constant(input: Span) -> IResult<Span, String> {
    let identifier = recognize((
        take_while(|c: char| c == '_'),
        one_of("abcdefghijklmnopqrstuvwxyz"),
        take_while(|c: char| c.is_ascii_alphanumeric() || c == '_' || c == '\''),
    ));

    map(identifier, |s: Span| s.to_string()).parse(input)
}

fn parse_anonymous(input: Span) -> IResult<Span, String> {
    map(tag("_"), |s: Span| s.to_string()).parse(input)
}

fn parse_term(input: Span) -> IResult<Span, Literal> {
    let (input, predicate) = preceded(multispace0, parse_constant).parse(input)?;
    let (input, args) = opt(delimited(
        (multispace0, tag("("), multispace0),
        separated_list0(
            (multispace0, tag(","), multispace0),
            alt((
                parse_constant,
                parse_variable,
                parse_integer,
                parse_anonymous,
            )),
        ),
        (multispace0, tag(")")),
    ))
    .parse(input)?;
    Ok((input, Literal::new(predicate, args.unwrap_or_default())))
}

fn parse_lit(input: Span) -> IResult<Span, Lit> {
    let (input, term) = parse_term(input)?;

    // let task = input.extra.clone();
    // let lit = task.borrow().create_literal(term);
    let task = input.extra.clone();
    let task = task.borrow_mut();
    let lit = task.create_literal(term);
    Ok((input, lit))
}

fn parse_answer_set(input: Span) -> IResult<Span, LitSet> {
    let f = input.fragment();
    let (input, terms) = delimited(
        (multispace0, tag("{"), multispace0),
        separated_list0((multispace0,), parse_lit),
        (multispace0, tag("}")),
    )
    .parse(input)?;
    Ok((input, LitSet::new(terms)))
}

fn parse_example(input: Span) -> IResult<Span, ()> {
    let mut input = input;
    loop {
        let (i, is_com) = parse_ignore(input)?;
        input = i;
        if !is_com {
            break;
        }
    }
    let (input, facts) = preceded(
        (multispace0, tag("I:"), multispace0),
        separated_list0(multispace1, parse_lit),
    )
    .parse(input)?;
    let (input, _) = preceded(multispace0, tag(".")).parse(input)?;
    let (input, mut outputs) = preceded(
        (multispace0, tag("O:"), multispace0),
        separated_list0(multispace1, parse_answer_set),
    )
    .parse(input)?;
    for o in outputs.iter_mut() {
        o.extend(facts.iter().cloned());
    }
    let task = input.extra.clone();
    let mut task = task.borrow_mut();
    task.push_example(Example {
        input: crate::LitSet::new(facts),
        output: outputs.into_iter().collect(),
    });

    Ok((input, ()))
}

fn parse_examples(input: Span) -> IResult<Span, ()> {
    let (input, _) = many0(parse_example).parse(input)?;
    let (input, _) = parse_ignore(input)?;
    Ok((input, ()))
}



pub fn parse_input(input: Span) -> IResult<Span, ()> {
    // let (input, _) = parse_background(input)?;
    let (input, _) = parse_examples(input)?;
    Ok((input, ()))
}
pub fn parse_ignore(input: Span) -> IResult<Span, bool> {
    let (input, _) = multispace0(input)?;

    let (i, is_comment) = opt(tag("%")).parse(input.clone())?;
    if is_comment.is_some() {
        let (input, _) = take_while(|c: char| c != '\n' && c != '\r')(i)?;
        let (input, _) = multispace0(input)?;
        return Ok((input, true));
    }


    Ok((input, false))
}
/// Parse a task
pub fn parse_task(input: &str) -> Result<Task, IlnlpError> {
    let task = Rc::new(RefCell::new(Task::default()));
    let input = Span::new_extra(input, task.clone());
    let (input, _) = parse_input(input)?;
    let (input, _) = parse_ignore(input)?;
    if !input.is_empty() {
        // Use Span's location information to generate detailed error message
        let line = input.location_line();
        let column = input.get_utf8_column();
        let fragment = input.fragment();

        // Truncate the unparsed content for display
        let error_content = if fragment.len() > 20 {
            format!("{}...", &fragment[..20])
        } else {
            fragment.to_string()
        };

        return Err(IlnlpError::ParserError(format!(
            "Unparsable content at line {}, column {}: '{}'",
            line, column, error_content
        )));
    }
    let c = task.take();
    Ok(c)
}

pub fn parse_background(input: &str) -> Result<Vec<String>, IlnlpError> {
    let mut backgrounds = Vec::new();
    for line in input.lines() {
        match line.strip_prefix(" ") {
            Some(l) => {
                if !l.starts_with("%") && !l.is_empty() {
                    backgrounds.push(l.to_string());
                }
            }
            None => {}
        }
    }
    Ok(backgrounds)
}
