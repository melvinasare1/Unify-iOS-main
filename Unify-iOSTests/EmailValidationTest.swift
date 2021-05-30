//
//  Unify_iOSTests.swift
//  Unify-iOSTests
//
//  Created by Melvin Asare on 19/10/2020.
//

import XCTest
@testable import Unify_iOS

class EmailValidationTest: XCTestCase  {

    var viewController: TestViewController!

    override func setUp() {
        super.setUp()
        viewController = TestViewController()
    }

    func test_is_email_valid() throws {
        XCTAssertTrue(viewController.isEmailValid("melvin@gmail.com"))
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
}
