//
//  UsernameValidationTest.swift
//  Unify-iOSTests
//
//  Created by Melvin Asare on 05/05/2021.
//

import XCTest
@testable import Unify_iOS

class UsernameValidationTest: XCTestCase {

    let username = "Tedddd"
    var viewController: UIViewController!

    override func setUpWithError() throws {
        super.setUp()
        viewController = UIViewController()
    }

    func test_username_has_no_special_chars() {
        XCTAssertFalse(viewController.hasSpecChars(text: username))
    }

    func test_username_length() {
        XCTAssertTrue(viewController.isUsernameValidLength(username))
    }

    override func tearDownWithError() throws {
        viewController = nil
        super.tearDown()
    }
}
