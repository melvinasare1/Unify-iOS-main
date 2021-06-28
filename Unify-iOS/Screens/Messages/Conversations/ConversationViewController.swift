//
//  MessagesViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 06/03/2021.
//

import Floaty
import JGProgressHUD

class ConversationViewController: UIViewController {
    private var viewModel: ConversationsViewModel!

    private let noConversationLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "No Conversations"
        return name
    }()

    private lazy var loadingIndicator: JGProgressHUD = {
        let hud = JGProgressHUD()
        hud.textLabel.text = Unify.strings.loading
        hud.backgroundColor = .darkGray
        return hud
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.isHidden = true
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

    @objc func presentComposeMessageController() {
        navigationController?.present(ComposeNewMessageController(), animated: true, completion: nil)
    }
    
    init(viewModel: ConversationsViewModel) {
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
}

extension ConversationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Unify.strings.cell, for: indexPath) as! ConversationsTableViewCell
        return cell
    }
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let viewController = ChatLogViewController(viewModel: ChatLogViewModel())
    //        viewController
    //
    //    }
}

extension ConversationViewController: FloatyDelegate {
    struct Consts {
        static let floatingButtonWidth: CGFloat = 52.0
        static let floatingButtonPadding: CGFloat = 28.0
    }
    @objc func returnToHome() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func returnToMessages() {
        self.dismiss(animated: true, completion: nil)
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

private extension ConversationViewController {
    func setup() {
        removeBarButtonItems()

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(presentComposeMessageController))
        navigationController?.navigationItem.rightBarButtonItem = rightBarButtonItem

        view.backgroundColor = .white
        title = Unify.strings.messages

        view.addSubview(loadingIndicator)
        view.addSubview(floatingActionButton)

        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.allowsSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        floatingActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        floatingActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Consts.floatingButtonPadding).isActive = true
        floatingActionButton.heightAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true
        floatingActionButton.widthAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true


        viewModel.startListeningForConversations { result in
            print(result)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
}
