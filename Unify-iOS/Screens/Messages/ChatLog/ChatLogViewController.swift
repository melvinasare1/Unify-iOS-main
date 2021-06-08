//
//  ChatLogViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import UIKit
import FirebaseDatabase
import MessageKit

class ChatLogViewController: UIViewController {

    private var messages = [Messages]()

    private let sender = Sender(senderId: "1", displayName: "Jason", photoUrl: "")

    private lazy var messagesCollectionView: MessagesCollectionView = {
        let collectionView = MessagesCollectionView()
        collectionView.messagesDataSource = self
        collectionView.messagesDisplayDelegate = self
        collectionView.messagesLayoutDelegate = self
        collectionView.backgroundColor = .green
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let userNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
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

        userNameLabel.text = viewModel.user.name

        navigationItem.title = userNameLabel.text
        navigationController?.navigationBar.prefersLargeTitles = false
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
        messages.count
    }
}
