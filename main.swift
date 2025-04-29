import XCTest
import StaticLinking


class StaticLinkingTests: XCTestCase {
  func testLibrary() {
    let strideTo = stride(from: CustomType(value: 1), to: 5, by: 2)
    XCTAssertEqual(1, strideTo.min()!)
    XCTAssertEqual(3, strideTo.max()!)

    let items: [CustomType] = [0, 1, 2, 3]
    XCTAssertEqual(String(describing: items), "[0, 1, 2, 3]")
  }
}

var tests = [XCTestCaseEntry]()
tests += [testCase([("testLibrary", StaticLinkingTests.testLibrary)])]
XCTMain(tests)

