//
//  ChatLogViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import Foundation

class ChatLogViewModel {

    public let user: User
    public let otherUserEmail: String
    public let conversationId: String?
    public let username: String
    public var messages = [Message]()

    public func listenForMessages(id: String, completion: (([Message])-> (Void))?) {
        CommunicationManager.shared.getAllMessagesForConversation(with: id) { [weak self] result in
            switch result {
            case .success(let messages):
                guard !messages.isEmpty else { return }
                self?.messages = messages
                completion!(messages)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    init(user: User,otherUserEmail: String, conversationId: String?, username: String) {
        self.user = user
        self.conversationId = conversationId
        self.username = username
        self.otherUserEmail = otherUserEmail

        // Only listen for messages once a conversation ID exists
        if let convoId = conversationId {
            listenForMessages(id: convoId, completion: nil)
        }
    }
}
