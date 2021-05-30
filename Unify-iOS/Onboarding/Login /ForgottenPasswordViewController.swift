//
//  ForgottenPasswordViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 12/04/2021.
//

import UIKit

class ForgottenPasswordViewController: UIViewController {

    private let pagetitle: UnifyTitleLabel = {
        let title = UnifyTitleLabel()
        title.configure(textAlignment: .left,
                        fontSize: 20,
                        titleText: Unify.strings.forgotten_password)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: Unify.strings.unift_logo)
        return image
    }()

    private let emailTextField: UnifyTextField = {
        let textfield = UnifyTextField()
        textfield.configure(placeholder: Unify.strings.please_enter_email,
                            color: .lightGray,
                            textAlignment: .left,
                            isSecureTextEntry: false)
        return textfield
    }()

    private lazy var resetButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.resetPassword,
                         textColor: .white,
                         backgroundColors: .unifyBlue)
        button.addTarget(self, action: #selector(resetPasswordPressed), for: .touchUpInside)
        return button
    }()

    @objc func resetPasswordPressed() {
        guard let email = emailTextField.text else { return }
        AccountManager.account.resetUserPassword(email: email)
    }

    @objc func backToPreviousPage() {
        let loginPage = LoginViewController(viewModel: LoginViewModel())
        self.navigationController?.present(loginPage, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension ForgottenPasswordViewController {
    func setup() {
        view.backgroundColor = .white

        view.addSubview(emailTextField)
        view.addSubview(pagetitle)
        view.addSubview(logoImageView)
        view.addSubview(resetButton)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.arrow_backward), style: .plain, target: self, action: #selector(returnToMainPage))

        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        pagetitle.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 36).isActive = true
        pagetitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        emailTextField.topAnchor.constraint(equalTo: pagetitle.bottomAnchor, constant: 36).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true

        resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
}
