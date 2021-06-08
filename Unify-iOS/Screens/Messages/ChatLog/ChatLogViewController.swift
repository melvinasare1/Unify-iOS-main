//
//  ChatLogViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import UIKit
import FirebaseDatabase
import MessageKit

class ChatLogViewController: MessagesViewController {

    private var messages = [Messages]()

    private let sender = Sender(senderId: "1", displayName: "Jason", photoUrl: "")

    private lazy var messagesCollectionView: MessagesCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.messagesDataSource = self
        collectionView.messagesDisplayDelegate = self
        collectionView.messagesLayoutDelegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let userNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

//    private let viewModel: ChatLogViewModel!
//
//    init(viewModel: ChatLogViewModel) {
//        self.viewModel = viewModel
//        super.init(viewModel: MessagesViewModel())
//    }

//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        messages.append(Messages(sender: sender, messageId: "1", sentDate: Date(), kind: .text("Hello")))
        messages.append(Messages(sender: sender, messageId: "1", sentDate: Date(), kind: .text("Hello hello Hello hello")))
    }
}

private extension ChatLogViewController {

    func setup() {
        view.addSubview(messagesCollectionView)

        view.backgroundColor = .white

        userNameLabel.text = "viewModel.user.name"

        navigationItem.title = userNameLabel.text
        navigationController?.navigationBar.prefersLargeTitles = false

        messagesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        messagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        messagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ChatLogViewController: MessagesDataSource, MessagesDisplayDelegate, MessagesLayoutDelegate {

    func currentSender() -> SenderType {
        return sender
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}
