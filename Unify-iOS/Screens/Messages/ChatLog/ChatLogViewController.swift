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

    private var messages = [Message]()

    private let sender = Sender(senderId: "1", displayName: "Jason", photoUrl: "")

    private let userNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self

        messages.append(Message(sender: sender, messageId: "1", sentDate: Date(), kind: .text("Hello")))
        messages.append(Message(sender: sender, messageId: "1", sentDate: Date(), kind: .text("Hello hello Hello hello")))
    }
}

private extension ChatLogViewController {

    func setup() {
        view.backgroundColor = .white

        userNameLabel.text = "viewModel.user.name"

        navigationItem.title = userNameLabel.text
        navigationController?.navigationBar.prefersLargeTitles = false

    }
}

extension ChatLogViewController: MessagesDataSource, MessagesDisplayDelegate, MessagesLayoutDelegate {

    func currentSender() -> SenderType {
        return sender
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        print(messages[indexPath.section])
        return messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        print(messages.count)
        return messages.count
    }
}
