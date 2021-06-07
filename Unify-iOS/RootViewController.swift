//
//  RootViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 12/05/2021.
//

import JGProgressHUD

class RootViewController: UIViewController {

    private lazy var loadingIndicator: JGProgressHUD = {
        let hud = JGProgressHUD()
        hud.textLabel.text = Unify.strings.loading
        hud.show(in: self.view, animated: true)
        hud.backgroundColor = .darkGray
        return hud
    }()

    func presentOnboardingIfNeeded() {
        if AccountManager.account.currentUser == nil {
            self.navigationController?.pushViewController(UserLoginOptionsViewController(viewModel: UserLoginViewModel()), animated: true)
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loadingIndicator)

        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        add(childViewController: HomeViewController(viewModel: HomeViewModel()), to: self.view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentOnboardingIfNeeded()
    }
}
