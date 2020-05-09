import XCTest

import FrameworkTests

var tests = [XCTestCaseEntry]()
tests += FrameworkTests.allTests()
XCTMain(tests)
