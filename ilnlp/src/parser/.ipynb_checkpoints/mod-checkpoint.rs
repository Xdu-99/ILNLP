use std::{cell::RefCell,  rc::Rc};

use nom::{
    IResult, Parser,
    branch::alt,
    bytes::complete::{tag, take_while},
    character::complete::{
         digit1, multispace0, multispace1, one_of,
    },
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
        take_while(|c: char| c.is_ascii_alphanumeric() || c == '_' || c == '\''),
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


fn parse_comparison(input: Span) -> IResult<Span, BodyLiteral> {
    let (input, left) = preceded(multispace0, alt((parse_variable, parse_integer))).parse(input)?;
    let (input, op) = preceded(multispace0, alt((tag("!="), tag(">"), tag("<")))).parse(input)?;
    let (input, right) =
        preceded(multispace0, alt((parse_variable, parse_integer))).parse(input)?;
    let comparison = match op.trim() {
        "!=" => Comparison::NotEqual(left, right),
        ">" => Comparison::Greater(left, right),
        "<" => Comparison::Less(left, right),
        _ => unreachable!(),
    };
    Ok((input, BodyLiteral::Comparison(comparison)))
}

fn parse_body_literal(input: Span) -> IResult<Span, BodyLiteral> {
    alt((
        map(
            (opt(preceded(multispace0, tag("not "))), parse_term),
            |(not, term)| BodyLiteral::Literal {
                literal: term,
                negated: not.is_some(),
            },
        ),
        parse_comparison,
    ))
    .parse(input)
}

//  :- p(X), not q(Y), X!=Y.
fn parse_rule(input: Span) -> IResult<Span, ()> {
    let (input, head) = opt(parse_term).parse(input)?;
    let (input, imp) = preceded(multispace0, opt(tag(":-"))).parse(input)?;

    if imp.is_none() {
        // check fact
        let head = head.ok_or_else(||nom::Err::Error(nom::error::Error::new(input.clone(), nom::error::ErrorKind::Verify)))?;
        
        let (input, _) = preceded(multispace0, tag(".")).parse(input)?;
        
        let task = input.extra.clone();
        task.borrow_mut().push_background(Rule { head: Some(head), body: vec![] });
        Ok((input, ()))
    } else {
        // parse body
        let (input, body) = separated_list1(
            (multispace0, tag(","), multispace0), 
            parse_body_literal
        ).parse(input)?;
        
        let (input, _) = preceded(multispace0, tag(".")).parse(input)?;
        
        let task = input.extra.clone();
        task.borrow_mut().push_background(Rule { head, body });
        Ok((input, ()))
    }
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
    let (input, terms) = delimited(
        (multispace0, tag("{"), multispace0),
        separated_list0((multispace0,), parse_lit),
        (multispace0, tag("}")),
    )
    .parse(input)?;
    Ok((input, LitSet::new(terms)))
}


fn parse_example(input: Span) -> IResult<Span, ()> {
    let (input, facts) = preceded(
        (multispace0, tag("I:"), multispace0),
        separated_list0(multispace1, parse_lit),
    )
    .parse(input)?;
    let (input, outputs) = preceded(
        (multispace0, tag("O:"), multispace0),
        separated_list0(multispace1, parse_answer_set),
    )
    .parse(input)?;
    let task = input.extra.clone();
    let mut task = task.borrow_mut();
    task.push_example(Example {
        input: crate::LitSet::new(facts),
        output: outputs.into_iter().collect(),
    });

    Ok((input, ()))
}

fn parse_examples(input: Span) -> IResult<Span, ()> {
    let (input, _) = many0(preceded(parse_ignore, parse_example)).parse(input)?;
    let (input, _) = parse_ignore(input)?;
    Ok((input, ()))
}

fn parse_background(input: Span) -> IResult<Span, ()> {
    let (input, _) = many0(preceded(parse_ignore, parse_rule)).parse(input)?;
    let (input, _) = parse_ignore(input)?;
    Ok((input, ()))
}

pub fn parse_input(input: Span) -> IResult<Span, ()> {
    let (input, _) = parse_background(input)?;
    let (input, _) = parse_examples(input)?;
    Ok((input, ()))
}
pub fn parse_ignore(input: Span) -> IResult<Span, ()> {
    let (input, _) = multispace0(input)?;
    let (i, is_comment) = opt(tag("%")).parse(input.clone())?;
    if is_comment.is_some() {
        let (input, _) = take_while(|c: char| c != '\n' && c != '\r')(i)?;
        let (input, _) = multispace0(input)?;
        return Ok((input, ()));
    }
    Ok((input, ()))
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
