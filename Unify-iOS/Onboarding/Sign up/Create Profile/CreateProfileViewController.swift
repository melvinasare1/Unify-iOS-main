//
//  CreateProfileViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 03/11/2020.
//

import UIKit
import SearchTextField
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class CreateProfileViewController: UIViewController {

    private lazy var avatarView: UIImageView = {
        let avatar = UIImageView()
        let tapAvatar = UITapGestureRecognizer(target: self, action: #selector(avatarPressed))
        avatar.addGestureRecognizer(tapAvatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        avatar.backgroundColor = .unifyBlue
        avatar.clipsToBounds = true
        return avatar
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

    private let whatsYourName: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.whats_your_name,
                            color: .lightGray,
                            textAlignment: .left,
                            isSecureTextEntry: false)
        return textField
    }()

    private let whatsYourUniversity: UnifySearchTextField = {
        let textField = UnifySearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.what_university_do_you_go_to, color: .lightGray, textAlignment: .left)
        return textField
    }()

    private let whatAreYouStudying: UnifySearchTextField = {
        let textField = UnifySearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.what_are_you_studying, color: .lightGray, textAlignment: .left)
        return textField
    }()

    private let yearOfStudy: UnifySearchTextField = {
        let textField = UnifySearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.what_year_are_you_in, color: .lightGray, textAlignment: .left)
        return textField
    }()

    private lazy var createAccountButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.create_account, textColor: .white, backgroundColors: .unifyBlue)
        button.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        return button
    }()

    private lazy var readTermsOfService: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.click_to_read_terms_of_service, textColor: .unifyBlue, backgroundColors: .clear)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(readTermsOfServicePressed), for: .touchUpInside)
        return button
    }()

    private let viewModel: CreateProfileViewModel

    init(viewModel: CreateProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarView.layer.cornerRadius = avatarView.frame.width / 2
    }

    @objc func readTermsOfServicePressed() {
        print("2")
    }

    @objc func backToMainPage() {
        self.navigationController?.pushViewController(SignUpViewController(viewModel: SignupViewModel()), animated: true)
    }

    @objc func createAccountPressed() {
        guard
            let name = whatsYourName.text,
            let university = whatsYourUniversity.text,
            let course = whatAreYouStudying.text,
            let year = yearOfStudy.text
        else { return }

        if name.isEmpty || university.isEmpty || course.isEmpty || year.isEmpty || !isUsernameValidLength(name) {
            print("error")
        } else {
            viewModel.updateUserProfile(name: name, university_name: university, course: course, yearOfStudy: year, { [weak self] success in
                guard success else { return }
                self?.navigationController?.pushViewController(HomeViewController(viewModel: HomeViewModel()), animated: true)
            })
            viewModel.uploadImageToDatabase(avatarView: avatarView, userId: viewModel.userId)
        }
    }

    override func viewDidLoad() {
        setup()
    }

    struct Constants {
        static let avatarDimension: CGFloat = 130
        static let unifyLogoWidth: CGFloat = 0.6
        static let unifyLogoHeight: CGFloat = 0.15
        static let gap: CGFloat = 20
        static let subtitleWidth: CGFloat = 0.9
        static let onboardingLogoHeight: CGFloat = 0.35
        static let buttonWidths: CGFloat = 0.85
        static let buttonHeights: CGFloat = 0.067
        static let footerButtonGap: CGFloat = 10
        static let footerButtonHeight: CGFloat = 0.05
    }
}

private extension CreateProfileViewController {
    func setup() {

        view.backgroundColor = .white

        filterThroughCourses(to: viewModel.courseFilter, courseTextField: whatAreYouStudying)
        filterThroughYear(to: viewModel.studyYearFilter, studyYearTextField: yearOfStudy)
        filterThroughUniversity(to: viewModel.universityFilter, universityTextField: whatsYourUniversity)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.arrow_backward), style: .plain, target: self, action: #selector(returnToMainPage))

        view.addSubview(pagetitle)
        view.addSubview(avatarView)
        view.addSubview(whatsYourName)
        view.addSubview(whatAreYouStudying)
        view.addSubview(whatsYourUniversity)
        view.addSubview(yearOfStudy)
        view.addSubview(createAccountButton)
        view.addSubview(readTermsOfService)

        pagetitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pagetitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pagetitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        pagetitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true

        avatarView.topAnchor.constraint(equalTo: pagetitle.bottomAnchor, constant: 10).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: Constants.avatarDimension).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: Constants.avatarDimension).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        whatsYourName.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 50).isActive = true
        whatsYourName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87).isActive = true
        whatsYourName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        whatsYourUniversity.topAnchor.constraint(equalTo: whatsYourName.bottomAnchor, constant: 50).isActive = true
        whatsYourUniversity.widthAnchor.constraint(equalTo: whatsYourName.widthAnchor).isActive = true
        whatsYourUniversity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        whatAreYouStudying.topAnchor.constraint(equalTo: whatsYourUniversity.bottomAnchor, constant: 50).isActive = true
        whatAreYouStudying.widthAnchor.constraint(equalTo: whatsYourName.widthAnchor).isActive = true
        whatAreYouStudying.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        yearOfStudy.topAnchor.constraint(equalTo: whatAreYouStudying.bottomAnchor, constant: 50).isActive = true
        yearOfStudy.widthAnchor.constraint(equalTo: whatsYourName.widthAnchor).isActive = true
        yearOfStudy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        createAccountButton.bottomAnchor.constraint(equalTo: readTermsOfService.topAnchor, constant: -10).isActive = true
        createAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        readTermsOfService.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        readTermsOfService.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        readTermsOfService.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
}

extension CreateProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        avatarView.contentMode = .scaleAspectFill
        avatarView.image = chosenImage
        dismiss(animated: true, completion: nil)

        guard chosenImage.pngData() != nil else { return }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @objc func avatarPressed() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
}
