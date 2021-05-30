//
//  ProfileViewController.swift
//  Unify-iOS
//
//  Created by melvin asare on 15/01/2021.
//

import Floaty

class ProfileViewController: UIViewController {

    private var viewModel: ProfileViewModel!

    private lazy var profileImageView: AvatarView = {
        let imageView = AvatarView(image: UIImage(named: "solidblue"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var usernameLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .left, fontSize: 30, titleText: viewModel.user.name )
        return label
    }()

    private lazy var universityLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .left, fontSize: 18, titleText: "University: \(viewModel.user.university.name)")
        return label
    }()

    private lazy var yearOfStudyLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .left, fontSize: 18, titleText:  "Year: \(viewModel.user.studyYear.year)")
        return label
    }()

    private lazy var courseLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .left, fontSize: 18, titleText: "Course: \(viewModel.user.course.name)")
        return label
    }()

    private lazy var messageButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: "Message", textColor: .white, backgroundColors: .systemGreen)
        button.addTarget(self, action: #selector(messageButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var addFriendButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: "Add", textColor: .white, backgroundColors: .systemGreen)
        button.addTarget(self, action: #selector(addFriendButtonPressed), for: .touchUpInside)
        return button
    }()

    @objc func messageButtonPressed() {
        print("hello")
    }

    @objc func addFriendButtonPressed() {
        print("hello")
    }

    private let loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    struct Consts {
        static let floatingButtonWidth: CGFloat = 52.0
        static let floatingButtonPadding: CGFloat = 28.0
    }

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

    init(viewModel: ProfileViewModel) {
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

private extension ProfileViewController {
    func setup() {
        removeBarButtonItems()

        view.backgroundColor = .white

        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(courseLabel)
        view.addSubview(universityLabel)
        view.addSubview(yearOfStudyLabel)
        view.addSubview(messageButton)
        view.addSubview(floatingActionButton)
        view.addSubview(loadingIndicatorView)

        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true

        universityLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        universityLabel.centerXAnchor.constraint(equalTo: usernameLabel.centerXAnchor).isActive = true
        universityLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor).isActive = true
        universityLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        courseLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        courseLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor).isActive = true
        courseLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        yearOfStudyLabel.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 10).isActive = true
        yearOfStudyLabel.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor).isActive = true
        yearOfStudyLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        messageButton.topAnchor.constraint(equalTo: yearOfStudyLabel.bottomAnchor, constant: 20).isActive = true
        messageButton.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor, constant: 10).isActive = true
        messageButton.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: -10).isActive = true
        messageButton.isHidden = true

        floatingActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        floatingActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Consts.floatingButtonPadding).isActive = true
        floatingActionButton.heightAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true
        floatingActionButton.widthAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true

        loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension ProfileViewController: FloatyDelegate {

    @objc func returnToHome() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func returnToMessages() {
        let viewModel = MessagesViewModel()
        let viewController = MessagesViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func returnToProfile() {
        let viewModel = ProfileViewModel(user: User(name: "Melvin Asare", email: "melvinasare@gmail.com", profile_picture_url: "crocker", toId: "dvmmkfmvfkvf", is_Online: true, university: University(name: "Birmingham", location: "Birmingham", picture: "crocker"), course: Course(name: "Business"), studyYear: StudyYear(year: "year 2")))
        let viewController = ProfileViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func tempSignOut() {
        AccountManager.account.signout()
        let viewModel = UserLoginViewModel()
        let viewController = UserLoginOptionsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
