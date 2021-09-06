//
//  ConversationsViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 13/06/2021.
//

import Observable

struct ConversationsViewModel {

    public var convo: MutableObservable<[Conversation]>
    public var user: MutableObservable<[User]>
    
    init() {
        convo = MutableObservable(wrappedValue: [])
        user = MutableObservable(wrappedValue: [])
    }

    func conversation(for indexPath: IndexPath) -> Conversation? {
        return convo.wrappedValue.object(at: indexPath.row)
    }

    func users(for indexPath: IndexPath) -> User? {
        return user.wrappedValue.object(at: indexPath.row)
    }

    func fetchUserProfile() {
        NetworkManager.shared.fetchUserProfile { (users) in
            self.user.wrappedValue = users
        }
    }

    func startListeningForConversations(_ completion: @escaping ([Conversation]) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: Unify.strings.email) as? String else { return }
        let safeEmail = CommunicationManager.shared.safeEmail(emailAddress: email)

        CommunicationManager.shared.getAllConversations(for: safeEmail) { result in
            switch result {
            case .success(let successfulConversation):
                guard !successfulConversation.isEmpty else {
                    print("stops here")
                    return
                }

                self.convo.wrappedValue = successfulConversation
                
                completion(successfulConversation)

            case .failure(let error):
                print("stops here2")

                print(error.localizedDescription)
            }
        }
    }
}
