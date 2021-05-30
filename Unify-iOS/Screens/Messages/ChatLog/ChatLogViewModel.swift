//
//  ChatLogViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import Foundation

class ChatLogViewModel {

    public let user: User

    init(user: User) {
        self.user = user
    }

    func sendMessage(sentText: String) {
        guard let toId = user.toId else { return }
        CommunicationManager.shared.sendMessages(usersId: toId, sentText: sentText)
    }
}
