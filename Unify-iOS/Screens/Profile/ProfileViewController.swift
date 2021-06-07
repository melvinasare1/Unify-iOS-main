//
//  ProfileViewController.swift
//  Unify-iOS
//
//  Created by melvin asare on 15/01/2021.
//

import Floaty
import PanModal
import JGProgressHUD
import SDWebImage

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
        label.configure(textAlignment: .center, fontSize: 30, titleText: viewModel.user.name )
        return label
    }()

    private lazy var universityLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 18, titleText: viewModel.user.university.name)
        return label
    }()

    private lazy var yearOfStudyLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 18, titleText: viewModel.user.studyYear.year)
        return label
    }()

    private lazy var courseLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 18, titleText: viewModel.user.course.name)
        return label
    }()

    private lazy var menuButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: SFSymbols.ellipsis), for: .normal)
        button.addTarget(self, action: #selector(presentActionSheet), for: .touchUpInside)
        return button
    }()

    func configureProfileView() {
        if viewModel.user.profile_picture_url.isEmpty {
            profileImageView.backgroundColor = .unifyBlue
        } else {
            profileImageView.sd_setImage(with: URL(string: viewModel.user.profile_picture_url, relativeTo: nil))
        }
    }

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

    @objc func presentActionSheet() {
        let alertController = UIAlertController(title: "Please select an option", message: nil, preferredStyle: .actionSheet)

        let addFriendAction = UIAlertAction(title: "Add Friend", style: .default) { _ in
            print("add friend request")
        }
        let messageUserAction = UIAlertAction(title: "Send Message", style: .default) { _ in
            print("send friend message")
        }
        let cancelAaction = UIAlertAction(title: "Cancel", style: .destructive)

        alertController.addAction(addFriendAction)
        alertController.addAction(messageUserAction)
        alertController.addAction(cancelAaction)

        self.present(alertController, animated: true)
    }

    @objc func dismissKeyboard() {
        self.dismiss(animated: true)
    }
}

private extension ProfileViewController {
    func setup() {
        removeBarButtonItems()
        configureProfileView()

        view.backgroundColor = .white

        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(courseLabel)
        view.addSubview(universityLabel)
        view.addSubview(yearOfStudyLabel)
        view.addSubview(floatingActionButton)
        view.addSubview(menuButton)

        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20).isActive = true

        universityLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        universityLabel.centerXAnchor.constraint(equalTo: usernameLabel.centerXAnchor).isActive = true
        universityLabel.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor).isActive = true
        universityLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        courseLabel.topAnchor.constraint(equalTo: universityLabel.bottomAnchor, constant: 10).isActive = true
        courseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        courseLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        yearOfStudyLabel.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 10).isActive = true
        yearOfStudyLabel.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor).isActive = true
        yearOfStudyLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        floatingActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        floatingActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Consts.floatingButtonPadding).isActive = true
        floatingActionButton.heightAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true
        floatingActionButton.widthAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true
        floatingActionButton.backgroundColor = .red

        menuButton.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 15).isActive = true
        menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
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
        self.dismiss(animated: true, completion: nil)
    }

    @objc func tempSignOut() {
        AccountManager.account.signout()
        let viewModel = UserLoginViewModel()
        let viewController = UserLoginOptionsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension ProfileViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }

    var longFormHeight: PanModalHeight {
        return shortFormHeight
    }

    var anchorModalToLongForm: Bool {
        return false
    }

    var showDragIndicator: Bool {
        return false
    }
}
