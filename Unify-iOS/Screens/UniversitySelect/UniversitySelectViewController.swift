//
//  UniversitySelectViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 04/03/2021.
//

import Floaty
import Observable

class UniversitySelectViewController: UIViewController {

    enum Section { case main }

    private lazy var universityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UniversityCollectionViewCell.self, forCellWithReuseIdentifier: Unify.strings.cell)
        collectionView.delegate = self
        return collectionView
    }()

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

    private let viewModel: UniversitySelectViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, University>!
    private var disposable: Disposable?

    func checkIfUserIsLoggedIn() {
        viewModel.checkIfUsersLoggedIn { isUserLoggedIn in
            if !isUserLoggedIn {
                let viewController = UserLoginOptionsViewController(viewModel: UserLoginViewModel())
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        disposable = viewModel.universityObservable.observe { [weak self] university, _ in
            guard let self = self else { return }
            guard !university.isEmpty else { return }
            self.updateData(on: (self.viewModel.universityObservable.wrappedValue))
        }
    }

    init(viewModel: UniversitySelectViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UniversitySelectViewController {
    struct Consts {
        static let floatingButtonWidth: CGFloat = 52.0
        static let floatingButtonPadding: CGFloat = 28.0
    }

    func setup() {
        loadingIndicatorView.startAnimating()
        configureCollectionViewDataSource()
        configureSearchController()
        removeBarButtonItems()
       checkIfUserIsLoggedIn()

        viewModel.retrieveUniversityData { [weak self] university in
            guard let self = self else { return }

            self.viewModel.universityObservable.wrappedValue = university
            DispatchQueue.main.async {
                self.loadingIndicatorView.stopAnimating()
            }
        }

        title = Unify.strings.search_university

        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(universityCollectionView)
        view.addSubview(floatingActionButton)
        view.addSubview(loadingIndicatorView)

        universityCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        universityCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        universityCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        universityCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        floatingActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        floatingActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Consts.floatingButtonPadding).isActive = true
        floatingActionButton.heightAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true
        floatingActionButton.widthAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true

        loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

private extension UniversitySelectViewController {

    func configureCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, University>(collectionView: universityCollectionView, cellProvider: { (collectionView, indexPath, university) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Unify.strings.cell, for: indexPath) as? UniversityCollectionViewCell
            cell?.configure(university: university)
            return cell
        })
    }

    func updateData(on university: [University]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, University>()
        snapshot.appendSections([.main])
        snapshot.appendItems(university)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension UniversitySelectViewController: UISearchResultsUpdating, UISearchBarDelegate {

    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Unify.strings.search_university
        navigationItem.searchController = searchController
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            viewModel.isSearching = false
            updateData(on: viewModel.universityObservable.wrappedValue)
            return }
        viewModel.isSearching = true
        viewModel.filteredUniversity = viewModel.universityObservable.wrappedValue.filter { $0.name.lowercased().contains(filter.lowercased())}
        updateData(on: viewModel.filteredUniversity)
    }
}

extension UniversitySelectViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = HomeViewModel()
        let userViewController = HomeViewController(viewModel: viewModel)
        navigationController?.present(userViewController, animated: true)
    }
}

extension UniversitySelectViewController: FloatyDelegate {

    @objc func returnToHome() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func returnToMessages() {
//        let viewModel = MessagesViewModel()
//        let viewController = MessagesViewController(viewModel: viewModel)
//        navigationController?.pushViewController(viewController, animated: true)
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
