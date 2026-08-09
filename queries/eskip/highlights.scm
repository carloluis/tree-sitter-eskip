; Route id (heading)
(route_definition
  id: (identifier) @function)

; Predicate and filter names
(predicate
  name: (identifier) @function.method)
(filter
  name: (identifier) @function.method)

; Load balancing algorithms
(algorithm) @keyword

; Backend keywords
(shunt) @constant.builtin
(loopback) @constant.builtin
(dynamic) @constant.builtin

; Wildcard catch-all predicate
(wildcard) @operator

; Literals
(string) @string
(escape_sequence) @string.escape
(regexp) @string.regexp
(number) @number

; Comments
(comment) @comment

; Punctuation and operators
[
  "->"
  "&&"
] @operator

[
  ":"
  ";"
  ","
] @punctuation.delimiter

[
  "("
  ")"
  "<"
  ">"
] @punctuation.bracket
