//
//  LoginViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 19/10/2020.
//

import UIKit

class LoginViewController: UIViewController {

    private let pagetitle: UnifyTitleLabel = {
        let title = UnifyTitleLabel()
        title.configure(textAlignment: .center,
                        fontSize: 40,
                        titleText: Unify.strings.login)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let onboardingImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: Unify.strings.loginScreenImage)
        return image
    }()

    private let emailTextField: UnifyTextField = {
        let textfield = UnifyTextField()
        textfield.configure(placeholder: Unify.strings.please_enter_email,
                            color: .lightGray,
                            textAlignment: .left,
                            isSecureTextEntry: false)
        textfield.isUserInteractionEnabled = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    private let passwordTextField: UnifyTextField = {
        let textfield = UnifyTextField()
        textfield.configure(placeholder: Unify.strings.please_enter_password,
                            color: .lightGray,
                            textAlignment: .left,
                            isSecureTextEntry: true)
        return textfield
    }()

    private lazy var dontHaveAnAccount: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.dont_have_an_account,
                         textColor: .unifyBlue,
                         backgroundColors: .clear)
        button.addTarget(self, action: #selector(dontHaveAnAccountPressed), for: .touchUpInside)
        return button
    }()

    private lazy var forgottenPasswordImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: SFSymbols.questionmark_circle), for: .normal)
        button.addTarget(self, action: #selector(forgottenPasswordPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var loginButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.login,
                         textColor: .white,
                         backgroundColors: .unifyBlue)
        button.addTarget(self, action: #selector(loginUsingEmail), for: .touchUpInside)
        return button
    }()

    private let viewModel: LoginViewModel

    @objc func backToMainPage() {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is UserLoginOptionsViewController {
                _ = self.navigationController?.popToViewController(vc as! UserLoginOptionsViewController, animated: true)
            }
        }
    }
    
    @objc func dontHaveAnAccountPressed() {
        let signupViewModel = SignupViewModel()
        self.navigationController?.pushViewController(SignUpViewController(viewModel: signupViewModel), animated: true)
    }

    @objc func forgottenPasswordPressed() {
        let forgottenPassword = ForgottenPasswordViewController()
        self.navigationController?.pushViewController(forgottenPassword, animated: true)
    }

    @objc func loginUsingEmail() {
        print("button pressed")
        guard let email = emailTextField.text, let password = passwordTextField.text  else { return }

        if email.isEmpty && password.isEmpty {
            self.presentCDAlert(title: "Error", message: "Please check you've entered the correct email & password", buttonTitle: "ok", type: .error)
        } else {
            viewModel.signinWithEmail(email: email, password: password) { [weak self] success in
                guard let self = self else { return }
                if success {
                    let homePage = HomeViewController(viewModel: HomeViewModel())
                    self.navigationController?.pushViewController(homePage, animated: true)
                }
            }
        }
    }

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}

private extension LoginViewController {

    struct Constants {
        static let topAnchor: CGFloat = 20
        static let pageTitleWidth: CGFloat = 0.5
        static let gap: CGFloat = 10
        static let onboardingLogoHeight: CGFloat = 0.40
        static let buttonWidths: CGFloat = 1
        static let itemSize: CGFloat = 0.6
        static let footerButtonGap: CGFloat = 4
        static let footerButtonHeight: CGFloat = 0.05
        static let textFieldPadding: CGFloat = 55
    }

    func setup() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.arrow_backward), style: .plain, target: self, action: #selector(returnToMainPage))

        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(onboardingImage)
        view.addSubview(pagetitle)
        view.addSubview(forgottenPasswordImageView)
        view.addSubview(loginButton)
        view.addSubview(dontHaveAnAccount)

        pagetitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pagetitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pagetitle.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        onboardingImage.topAnchor.constraint(equalTo: pagetitle.bottomAnchor, constant: Constants.gap).isActive = true
        onboardingImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        onboardingImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.onboardingLogoHeight).isActive = true

        emailTextField.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor, constant: Constants.gap).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: onboardingImage.widthAnchor, multiplier: 0.9).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        forgottenPasswordImageView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        forgottenPasswordImageView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true

        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.itemSize).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: dontHaveAnAccount.topAnchor, constant: -Constants.itemSize).isActive = true

        dontHaveAnAccount.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.footerButtonGap).isActive = true
        dontHaveAnAccount.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        dontHaveAnAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
