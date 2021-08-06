//
//  UsersViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 26/10/2020.
//

import PanModal
import Observable
import Floaty
import FirebaseDatabase

class HomeViewController: UIViewController {

    private let viewModel: HomeViewModel
    private var disposable: Disposable?
    private let userDefaults = UserDefaults()

    private let loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var floatingActionButton: Floaty = {
        let view = Floaty()
        Floaty.global.rtlMode = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fabDelegate = self
        view.overlayColor = .clear
        view.openAnimationType = .slideUp
        view.size = Consts.floatingButtonWidth
        view.buttonColor = .unifyBlue
        view.plusColor = .white
        view.paddingX = Consts.floatingButtonPadding
        view.paddingY = Consts.floatingButtonPadding
        view.relativeToSafeArea = true
        view.itemSpace = 18.0
        view.addUnifyAction(title: Unify.strings.sign_out, color: .unifyBlue) { [weak self] in self?.tempSignOut() }
        view.addUnifyAction(title: Unify.strings.profile, color: .unifyBlue) { [weak self] in self?.returnToProfile() }
        view.addUnifyAction(title: Unify.strings.messages, color: .unifyBlue) { [weak self] in self?.returnToMessages() }
        view.addUnifyAction(title: Unify.strings.home, color: .unifyBlue) { [weak self] in self?.returnToHome() }
        return view
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        disposable = viewModel.users.observe { [weak self] _, _ in
            self?.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

private extension HomeViewController {
    func setup() {
        removeBarButtonItems()

        viewModel.checkIfUsersLoggedIn { isLoggedIn in
            if !isLoggedIn {
                self.navigationController?.pushViewController(UserLoginOptionsViewController(viewModel: UserLoginViewModel()), animated: true)
            }
        }

        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(floatingActionButton)
        view.addSubview(loadingIndicatorView)

        navigationController?.navigationBar.prefersLargeTitles = true
        title = Unify.strings.users

        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.allowsSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        floatingActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        floatingActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Consts.floatingButtonPadding).isActive = true
        floatingActionButton.heightAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true
        floatingActionButton.widthAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true

        loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.wrappedValue.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Unify.strings.cell, for: indexPath) as! HomePageTableViewCell

        if let user = viewModel.user(for: indexPath) {
            cell.configure(with: user)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentPanModal(ProfileViewController(viewModel: ProfileViewModel(user: viewModel.users.wrappedValue[indexPath.row])))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let message = UIContextualAction(style: .normal, title: Unify.strings.message) { (action, view, nil) in
            let user = self.viewModel.user(for: indexPath)
            let viewModel = ChatLogViewModel(user: user!, otherUserEmail: "", conversationId: "", username: "")
            let viewController = ChatLogViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(viewController, animated: true)
        }

        let hide = UIContextualAction(style: .destructive, title: Unify.strings.hide) { (action, view, nil) in
            //    let users = self.viewModel.users.wrappedValue[indexPath.row]
            print("hide user")
        }
        message.backgroundColor = .systemGreen
        hide.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [message, hide])
    }

    struct Consts {
        static let floatingButtonWidth: CGFloat = 52.0
        static let floatingButtonPadding: CGFloat = 28.0
        static let avatarHeight: CGFloat = 40.0
        static let viewPadding: CGFloat = 12.0
        static let avatarOptionsWidth: CGFloat = 32.0
    }
}

extension HomeViewController: FloatyDelegate {

    @objc func returnToHome() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func returnToMessages() {
        let viewModel = ConversationsViewModel()
        let viewController = ConversationViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func returnToProfile() {
        let viewModel = ProfileViewModel(user: User(name: "Melvin Asare", email: "melvinasare@gmail.com", profile_picture_url: "crocker", toId: "dvmmkfmvfkvf", is_Online: true, university: University(name: "Birmingham", location: "Birmingham", picture: "crocker"), course: Course(name: "Business"), studyYear: StudyYear(year: "year 2")))
        let viewController = ProfileViewController(viewModel: viewModel)
        self.presentPanModal(viewController)
    }

    @objc func tempSignOut() {
        AccountManager.account.signout()
        let viewModel = UserLoginViewModel()
        let viewController = UserLoginOptionsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
