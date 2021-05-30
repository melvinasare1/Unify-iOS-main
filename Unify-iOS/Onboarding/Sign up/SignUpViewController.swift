//
//  ViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 19/10/2020.
//

import UIKit

class SignUpViewController: UIViewController {

    private let emailTextField: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.please_enter_email,
                            color: .lightGray,
                            textAlignment: .left,
                            isSecureTextEntry: false)
        return textField
    }()

    private let passwordTextField: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.please_enter_password,
                            color: .lightGray,
                            textAlignment: .left,
                            isSecureTextEntry: true)
        return textField
    }()

    private let pagetitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.text = Unify.strings.sign_up
        title.textAlignment = .center
        title.textColor = .unifyBlue
        title.font = .systemFont(ofSize: 40, weight: .bold)
        return title
    }()

    private let onboardingImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: Unify.strings.signupScreenImage)
        return image
    }()

    private lazy var signupButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.sign_up,
                         textColor: .white,
                         backgroundColors: .unifyBlue)
        button.addTarget(self, action: #selector(signupUsingEmail), for: .touchUpInside)
        return button
    }()

    private lazy var alreadyHasAccount: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.already_have_an_account, textColor: .unifyBlue, backgroundColors: .clear)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(alreadyHavenAnAccountPressed), for: .touchUpInside)
        return button
    }()
    private let viewModel: SignupViewModel

    @objc func alreadyHavenAnAccountPressed() {
        self.navigationController?.pushViewController(LoginViewController(viewModel: LoginViewModel()), animated: true)
    }
    
    @objc func returnToLoginOptions() {
        returnToMainPage()
    }

    @objc func signupUsingEmail() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }

        if email.isEmpty || password.isEmpty || !isEmailValid(email) || !isPasswordValid(password: password) {
            self.presentCustomAlert(title: "title error", message: "message error", buttonTitle: "ok")

        } else {
            viewModel.createUserWithEmail(email: email, password: password) { [weak self] userId in
                guard let self = self else { return }
                let createProfileVM = CreateProfileViewModel(userId: userId)
                let createProfileVC = CreateProfileViewController(viewModel: createProfileVM)

                self.navigationController?.pushViewController(createProfileVC, animated: true)
            }
        }
    }

    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    struct Constants {
        static let topAnchor: CGFloat = 20
        static let pageTitleWidth: CGFloat = 0.5
        static let gap: CGFloat = 30
        static let onboardingLogoHeight: CGFloat = 0.35
        static let buttonWidths: CGFloat = 1
        static let itemSize: CGFloat = 0.6
        static let footerButtonGap: CGFloat = 4
        static let footerButtonHeight: CGFloat = 0.05
        static let textFieldPadding: CGFloat = 55
    }
}

private extension SignUpViewController {
    func setup() {
        view.backgroundColor = .white

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.arrow_backward), style: .plain, target: self, action: #selector(returnToLoginOptions))

        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(onboardingImage)
        view.addSubview(pagetitle)
        view.addSubview(alreadyHasAccount)
        view.addSubview(signupButton)

        pagetitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pagetitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pagetitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.pageTitleWidth).isActive = true

        onboardingImage.topAnchor.constraint(equalTo: pagetitle.bottomAnchor, constant: Constants.topAnchor).isActive = true
        onboardingImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidths).isActive = true
        onboardingImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.onboardingLogoHeight).isActive = true
        onboardingImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onboardingImage.backgroundColor = .green

        emailTextField.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor, constant: Constants.textFieldPadding).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: onboardingImage.widthAnchor, multiplier: Constants.buttonWidths - 0.1).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constants.gap).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        signupButton.bottomAnchor.constraint(equalTo: alreadyHasAccount.topAnchor, constant: -Constants.itemSize).isActive = true
        signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.itemSize).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        alreadyHasAccount.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.footerButtonGap).isActive = true
        alreadyHasAccount.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        alreadyHasAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
