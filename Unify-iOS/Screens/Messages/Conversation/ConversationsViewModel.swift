//
//  MessagesViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 06/03/2021.
//

import Foundation

class ConversationsViewModel {

    init() {
        retrieveMessages()
    }

    func retrieveMessages() {
        CommunicationManager.shared.retrieveMessages { messages in
            print(messages)
        }
    }
}
