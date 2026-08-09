# tree-sitter-eskip

[Tree-sitter](https://tree-sitter.github.io/tree-sitter/) grammar for [eskip](https://pkg.go.dev/github.com/zalando/skipper/eskip) — the routing configuration language used by [Skipper](https://github.com/zalando/skipper).

![Skipper](https://raw.githubusercontent.com/zalando/skipper/master/img/skipper-h180.png)

## Language overview

Eskip is a DSL for defining HTTP routing rules. Each rule is a *route definition*: a named predicate expression, an optional chain of filters, and a backend target.

```eskip
// Route with predicates, filters, and a network backend
api: Method("GET") && Host(/^api\.example\.org$/) && Path("/api/:id")
  -> setRequestHeader("X-Foo", "bar")
  -> ratelimit(10, "1m")
  -> "https://backend.example.org";

// Catch-all that shunts (terminates) the request
catchall: * -> inlineContent("not found") -> status(404) -> <shunt>;

// Load-balanced backend with explicit algorithm
lb: Path("/lb")
  -> <roundRobin, "https://a.example.org", "https://b.example.org">;
```

## Supported constructs

| Construct | Example |
|---|---|
| Route definition | `name: predicates -> backend ;` |
| Predicate | `Path("/foo")`, `Method("GET")` |
| Multiple predicates | `Method("GET") && Path("/foo")` |
| Wildcard predicate | `*` |
| Filter chain | `-> setRequestHeader("X-A", "b") -> ratelimit(10, "1m")` |
| String backend | `-> "https://example.org"` |
| Shunt backend | `-> <shunt>` |
| Loopback backend | `-> <loopback>` |
| Dynamic backend | `-> <dynamic>` |
| Load-balanced backend | `-> <roundRobin, "https://a.org", "https://b.org">` |
| String arguments | `"double-quoted"`, `` `backtick raw` `` |
| Regexp arguments | `/^pattern$/` |
| Number arguments | `404`, `3.14`, `-1` |
| Comments | `// line comment` |

**Load-balancing algorithms:** `roundRobin`, `random`, `consistentHash`, `powerOfRandomNChoices`

## Syntax highlighting

The `queries/highlights.scm` file maps grammar nodes to standard Tree-sitter capture names:

| Capture | Node |
|---|---|
| `@function` | route identifier |
| `@function.method` | predicate / filter name |
| `@keyword` | lb algorithm |
| `@constant.builtin` | `shunt`, `loopback`, `dynamic` |
| `@operator` | `->`, `&&`, `*` |
| `@string` / `@string.regexp` / `@string.escape` | string / regexp / escape |
| `@number` | number |
| `@comment` | line comment |
| `@punctuation.delimiter` | `:`, `;`, `,` |
| `@punctuation.bracket` | `(`, `)`, `<`, `>` |

## Installation

### Node.js

```sh
npm install tree-sitter-eskip
```

```js
import Parser from "tree-sitter";
import Eskip from "tree-sitter-eskip";

const parser = new Parser();
parser.setLanguage(Eskip);
const tree = parser.parse(`hello: Path("/hello") -> "https://example.org";`);
```

### Rust

```toml
[dependencies]
tree-sitter-eskip = "0.1"
```

```rust
let language = tree_sitter_eskip::LANGUAGE;
```

### Python

```sh
pip install tree-sitter-eskip
```

```python
import tree_sitter_eskip
from tree_sitter import Language, Parser

lang = Language(tree_sitter_eskip.language())
parser = Parser(lang)
```

### Go

```sh
go get github.com/carloluis/tree-sitter-eskip
```

```go
import (
    "github.com/tree-sitter/go-tree-sitter"
    tree_sitter_eskip "github.com/carloluis/tree-sitter-eskip/bindings/go"
)

language := tree_sitter.NewLanguage(tree_sitter_eskip.Language())
```

### C

```c
#include "tree_sitter/parser.h"

const TSLanguage *tree_sitter_eskip(void);
```

Build with `make` or `cmake`.

## Development

```sh
# Regenerate parser from grammar.js
tree-sitter generate

# Run corpus tests
tree-sitter test

# Parse example files
tree-sitter parse examples/*.eskip --quiet --stat

# Launch the playground (builds WASM first)
npm start
```

## License

MIT
