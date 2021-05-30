//
//  UserLoginOptionsViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 19/10/2020.
//

import UIKit

class UserLoginOptionsViewController: UIViewController {

    private var viewModel: UserLoginViewModel

    private let unifyLogo: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: Unify.strings.unift_logo)
        logo.contentMode = .scaleAspectFit
        return logo
    }()

    private let onboardingImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: Unify.strings.welcomeScreenImage)
        return image
    }()

    private let subtitle: UnifyTitleLabel = {
        let title = UnifyTitleLabel()
        title.configure(textAlignment: .center, fontSize: 18, titleText: Unify.strings.different_students_different_unis_one_place)
        return title
    }()

    private lazy var emailLoginButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.email_signin, textColor: .white, backgroundColors: .unifyBlue)
        button.addTarget(self, action: #selector(transitionToLoginPage), for: .touchUpInside)
        return button
    }()

    private lazy var dontHaveAnAccount: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.dont_have_an_account,
                         textColor: .unifyBlue,
                         backgroundColors: .clear)
        button.addTarget(self, action: #selector(dontHaveAnAccountPressed), for: .touchUpInside)
        return button
    }()

    @objc func dontHaveAnAccountPressed() {
        print("pr2essed")

        let signupViewModel = SignupViewModel()
        self.navigationController?.pushViewController(SignUpViewController(viewModel: signupViewModel), animated: true)
    }

    @objc func transitionToLoginPage() {
        print("pressed")
        let loginViewModel = LoginViewModel()
        self.navigationController?.pushViewController(LoginViewController(viewModel: loginViewModel), animated: true)
    }

    @objc func phoneLoginPressed() {
        let loginViewModel = LoginViewModel()
        self.navigationController?.pushViewController(LoginViewController(viewModel: loginViewModel), animated: true)

    }

    init(viewModel: UserLoginViewModel) {
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
        navigationController?.isNavigationBarHidden = true
    }
    
    struct Constants {
        static let topAnchorGap: CGFloat = 30
        static let gap: CGFloat = 20
        static let itemSize: CGFloat = 0.6
        static let onboardingLogoHeight: CGFloat = 0.35
        static let buttonWidths: CGFloat = 150
        static let buttonHeights: CGFloat = 60
        static let footerButtonGap: CGFloat = 4
        static let footerButtonHeight: CGFloat = 0.05
    }
}

extension UserLoginOptionsViewController {

    func setup() {
        view.addSubview(unifyLogo)
        view.addSubview(subtitle)
        view.addSubview(onboardingImage)
        view.addSubview(emailLoginButton)
        view.addSubview(dontHaveAnAccount)

        unifyLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topAnchorGap).isActive = true
        unifyLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        subtitle.topAnchor.constraint(equalTo: unifyLogo.bottomAnchor, constant: Constants.gap).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        subtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        onboardingImage.topAnchor.constraint(equalTo: subtitle.bottomAnchor).isActive = true
        onboardingImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        onboardingImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.onboardingLogoHeight).isActive = true

        emailLoginButton.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor, constant: Constants.gap).isActive = true
        emailLoginButton.widthAnchor.constraint(equalTo:view.widthAnchor, multiplier: Constants.itemSize).isActive = true
        emailLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        dontHaveAnAccount.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.footerButtonGap).isActive = true
        dontHaveAnAccount.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        dontHaveAnAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
