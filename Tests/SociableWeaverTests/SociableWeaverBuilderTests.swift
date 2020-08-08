import XCTest
@testable import SociableWeaver

final class SociableWeaverBuilderTests: XCTestCase {
    func testBuildField() {
        let query = Weave(.query) {
            Field(Comment.CodingKeys.id)
        }

        let expected = "query { id }"
        XCTAssertEqual(String(describing: query), expected)
    }
    
    func testBuildObject() {
        let query = Weave(.query) {
            Object(Post.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
        }

        let expected = "query { post { id name } }"
        XCTAssertEqual(String(describing: query), expected)
    }
    
    func testBuildObjectWithAlias() {
        let query = Weave(.query) {
            Object(Post.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
            .alias("testAlias")
        }

        let expected = "query { testAlias: post { id name } }"
        XCTAssertEqual(String(describing: query), expected)
    }
    
    func testBuildObjectWithSchemaName() {
        let query = Weave(.query) {
            Object(Post.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
            .schemaName("testSchema")
        }

        let expected = "query { testSchema { id name } }"
        XCTAssertEqual(String(describing: query), expected)
    }
    
    func testBuildObjectWithArgument() {
        let query = Weave(.query) {
            Object(Post.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
            .argument(key: "testArgument", value: "test")
        }

        let expected = "query { post(testArgument: \"test\") { id name } }"
        XCTAssertEqual(String(describing: query), expected)
    }
    
    func testBuildObjectWithCaseStyle() {
        let query = Weave(.query) {
            Object(Post.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
            .caseStyle(.capitalized)
        }

        let expected = "query { Post { id name } }"
        XCTAssertEqual(String(describing: query), expected)
    }
    
    func testBuildObjectWithFalseInclude() {
        let query = Weave(.query) {
            Object(Post.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
            
            Object(Author.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
            .include(if: false)
        }

        let expected = "query { post { id name } }"
        XCTAssertEqual(String(describing: query), expected)
    }
    
    func testBuildObjectWithTrueSkip() {
        let query = Weave(.query) {
            Object(Post.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
            
            Object(Author.self) {
                Field(Author.CodingKeys.id)
                Field(Author.CodingKeys.name)
            }
            .skip(if: true)
        }

        let expected = "query { post { id name } }"
        XCTAssertEqual(String(describing: query), expected)
    }

    static var allTests = [
        ("testBuildField", testBuildField),
        ("testBuildObject", testBuildObject),
        ("testBuildObjectWithAlias", testBuildObjectWithAlias),
        ("testBuildObjectWithSchemaName", testBuildObjectWithSchemaName),
        ("testBuildObjectWithArgument", testBuildObjectWithArgument),
        ("testBuildObjectWithCaseStyle", testBuildObjectWithCaseStyle),
        ("testBuildObjectWithRemove", testBuildObjectWithFalseInclude),
        ("testBuildObjectWithTrueSkip", testBuildObjectWithTrueSkip),
    ]
}

