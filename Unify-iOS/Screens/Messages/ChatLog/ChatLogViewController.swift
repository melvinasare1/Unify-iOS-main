//
//  ChatLogViewController.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import UIKit
import FirebaseDatabase
import MessageKit
import InputBarAccessoryView
import Observable

class ChatLogViewController: MessagesViewController {

    private let viewModel: ChatLogViewModel!
    private var disposable: Disposable?

    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        formatter.locale = .current
        return formatter
    }()

    private var sender: Sender? {
        guard let email = UserDefaults.standard.value(forKey: "Email"),
              let picture = UserDefaults.standard.value(forKey: Unify.strings.profile_picture_uid)
        else { return nil }
        return Sender(senderId: email as! String,
                      displayName: "Jason",
                      photoUrl: picture as! String)
    }

    public var isNewConversation = true

    private let userNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

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

extension ChatLogViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty,
              let sender = self.sender,
              let messageId = createMessageId() else {
            print("error")
            return
        }

        print(text)

        if isNewConversation {
            let message = Message(sender: sender,
                                  messageId: messageId,
                                  sentDate: Date(),
                                  kind: .text(text))
            let safeEmail = CommunicationManager.shared.safeEmail(emailAddress: viewModel.otherUserEmail)
            CommunicationManager.shared.createNewConversatioon(with: safeEmail, name: self.title ?? "user", firstMessage: message) { success in
            }
        } else {
            print("error")
        }
    }

    private func createMessageId() -> String? {
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "Email") as? String else { return nil }

        let safeUserEmail = safeEmail(emailAddress: currentUserEmail)
        let dateString = ChatLogViewController.dateFormatter.string(from: Date())
        let safeCurrentEmail = safeEmail(emailAddress: viewModel.otherUserEmail)
        let newIdentifier = "\(safeCurrentEmail)_\(safeUserEmail)_\(dateString)"
        return newIdentifier
    }
}

private extension ChatLogViewController {

    func setup() {
        view.backgroundColor = .white

        title = viewModel.user.name
        navigationController?.navigationBar.prefersLargeTitles = false

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self

        guard let convoId = viewModel.conversationId else { return }

        viewModel.listenForMessages(id: convoId) { messages in
            DispatchQueue.main.async {
                self.messagesCollectionView.reloadDataAndKeepOffset()
            }
        }
    }
}

extension ChatLogViewController: MessagesDataSource, MessagesDisplayDelegate, MessagesLayoutDelegate {

    func currentSender() -> SenderType {
        return sender ?? Sender(senderId: "", displayName: "", photoUrl: "")
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return viewModel.messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return viewModel.messages.count
    }
}
