/**
 * @file A descriptive configuration language designed for routing rules in Skipper
 * @author Carloluis <carloluisr@gmail.com>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

export default grammar({
  name: "eskip",

  rules: {
    // TODO: add the actual grammar rules
    source_file: $ => "hello"
  }
});
