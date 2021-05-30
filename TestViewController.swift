//
//  TestViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 03/05/2021.
//

import UIKit

class TestViewController: UIViewController {

    private let emailTextField: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.please_enter_email,
                            color: .lightGray,
                            textAlignment: .left,
                            isSecureTextEntry: false)
        return textField
    }()

    private lazy var signupButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.sign_up,
                         textColor: .white,
                         backgroundColors: .unifyBlue)
        button.addTarget(self, action: #selector(testFunction), for: .touchUpInside)
        return button
    }()

    @objc func testFunction() {
        if isPasswordValid(password: emailTextField.text!) {
            print("Email is valid")
        } else {
            print("email is not valid")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(signupButton)

        emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        signupButton.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 200).isActive = true
        signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
}
