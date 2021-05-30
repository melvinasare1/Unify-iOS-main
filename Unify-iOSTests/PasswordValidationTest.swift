//
//  PasswordValidationTest.swift
//  Unify-iOSTests
//
//  Created by Melvin Asare on 05/05/2021.
//

import XCTest
@testable import Unify_iOS

class PasswordValidationTest: XCTestCase {

    var viewController: TestViewController!

    override func setUpWithError() throws {
        super.setUp()
        viewController = TestViewController()
    }

    func test_is_password_valid() {
      XCTAssertTrue(viewController.isPasswordValid(password: "cfjnvv82i9denSDKMC."))
    }

    override func tearDownWithError() throws {
        viewController = nil
        super.tearDown()
    }
}
