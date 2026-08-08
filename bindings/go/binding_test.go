package tree_sitter_eskip_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_eskip "github.com/carloluis/tree-sitter-eskip/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_eskip.Language())
	if language == nil {
		t.Errorf("Error loading Eskip grammar")
	}
}
