/**
 * @file A descriptive configuration language designed for routing rules in Skipper
 * @author Carloluis <carloluisr@gmail.com>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

export default grammar({
  name: 'eskip',

  word: $ => $.identifier,

  extras: $ => [
    /\s+/,
    $.comment,
  ],

  rules: {
    source_file: $ => repeat($.route_definition),

    route_definition: $ => seq(
      field('id', $.identifier),
      ':',
      field('predicates', $.predicate_list),
      '->',
      repeat(seq(field('filter', $.filter), '->')),
      field('backend', $.backend),
      ';',
    ),

    predicate_list: $ => choice(
      $.wildcard,
      seq($.predicate, repeat(seq('&&', $.predicate))),
    ),

    // The catch-all predicate that matches every request.
    wildcard: _ => '*',

    predicate: $ => seq(
      field('name', $.identifier),
      field('arguments', $.arguments),
    ),

    filter: $ => seq(
      field('name', $.identifier),
      field('arguments', $.arguments),
    ),

    arguments: $ => seq(
      '(',
      optional(seq($._value, repeat(seq(',', $._value)))),
      ')',
    ),

    _value: $ => choice(
      $.string,
      $.number,
      $.regexp,
    ),

    backend: $ => choice(
      $.string,
      $.shunt,
      $.loopback,
      $.dynamic,
      $.lb_backend,
    ),

    shunt: _ => seq('<', 'shunt', '>'),
    loopback: _ => seq('<', 'loopback', '>'),
    dynamic: _ => seq('<', 'dynamic', '>'),

    lb_backend: $ => seq(
      '<',
      optional(seq(field('algorithm', $.algorithm), ',')),
      field('endpoint', $.string),
      repeat(seq(',', field('endpoint', $.string))),
      '>',
    ),

    algorithm: _ => choice(
      'roundRobin',
      'random',
      'consistentHash',
      'powerOfRandomNChoices',
    ),

    string: $ => choice(
      seq('"', repeat(choice($._double_string_content, $.escape_sequence)), '"'),
      seq('`', optional($._raw_string_content), '`'),
    ),

    _double_string_content: _ => token.immediate(/[^"\\]+/),
    _raw_string_content: _ => token.immediate(/[^`]+/),
    escape_sequence: _ => token.immediate(/\\./),

    regexp: _ => token(seq('/', repeat(choice(/[^/\\\n]/, /\\./)), '/')),

    number: _ => token(/-?\d+(\.\d+)?/),

    identifier: _ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    comment: _ => token(seq('//', /[^\n]*/)),
  },
});
