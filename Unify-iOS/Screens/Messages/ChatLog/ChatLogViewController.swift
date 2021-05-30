//
//  ChatLogViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import UIKit
import FirebaseDatabase

class ChatLogViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChatLogCollectionViewCell.self, forCellWithReuseIdentifier: Unify.strings.cell)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private let userNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let seperatorLineView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var inputTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = Unify.strings.enter_message
        tf.delegate = self
        return tf
    }()

    private lazy var sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle(Unify.strings.send, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let viewModel: ChatLogViewModel!

    init(viewModel: ChatLogViewModel) {
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

private extension ChatLogViewController {

    func setup() {
        view.backgroundColor = .white
    
        view.addSubview(containerView)
        containerView.addSubview(inputTextField)
        containerView.addSubview(sendMessageButton)
        containerView.addSubview(seperatorLineView)

        userNameLabel.text = viewModel.user.name

        navigationItem.title = userNameLabel.text
        navigationController?.navigationBar.prefersLargeTitles = false

        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true

        seperatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperatorLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        seperatorLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        seperatorLineView.heightAnchor.constraint(equalToConstant: 0.7).isActive = true

        inputTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true

        sendMessageButton.leadingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: 0).isActive = true
        sendMessageButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        sendMessageButton.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 0).isActive = true
        sendMessageButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1).isActive = true
    }
}

extension ChatLogViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Unify.strings.cell, for: indexPath) as! ChatLogCollectionViewCell
        return cell
    }
}

extension ChatLogViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.sendMessage(sentText: inputTextField.text!)
        return true
    }
}
