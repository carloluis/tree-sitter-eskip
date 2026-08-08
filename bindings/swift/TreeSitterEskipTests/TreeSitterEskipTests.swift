import XCTest
import SwiftTreeSitter
import TreeSitterEskip

final class TreeSitterEskipTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_eskip())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Eskip grammar")
    }
}
