//
//  ConversationsViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 13/06/2021.
//

import Foundation

struct ConversationsViewModel {

    public var convo: [Conversation] = []

    func startListeningForConversations(_ completion: @escaping ([Conversation]) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: "Email") as? String else { return }
        let safeEmail = CommunicationManager.shared.safeEmail(emailAddress: email)

        CommunicationManager.shared.getAllConversations(for: safeEmail) { result in
            switch result {
            case .success(let successfulConversation):
                guard !successfulConversation.isEmpty else {
                    print("stops here")

                    return
                }

                completion(successfulConversation)

            case .failure(let error):
                print("stops here2")

                print(error.localizedDescription)
            }
        }
    }
}
