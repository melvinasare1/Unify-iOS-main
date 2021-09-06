//
//  UsersViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 20/11/2020.
//

import Foundation
import Observable
import FirebaseDatabase

class HomeViewModel {

    public var users: MutableObservable<[User]>
    public var convo: MutableObservable<[Conversation]>

    init() {
        users = MutableObservable(wrappedValue: [])
        convo = MutableObservable(wrappedValue: [])

        NetworkManager.shared.reset = true
        fetchUserProfile()
        
    }

    func checkIfUsersLoggedIn(_ compeltion: @escaping (Bool)-> Void) {
        AccountManager.account.checkIfUsersLoggedIn { (user, _) in
            if user == nil {
                compeltion(false)
            } else {
                compeltion(true)
            }
        }
    }

    func user(for indexPath: IndexPath) -> User? {
        return users.wrappedValue.object(at: indexPath.row)
    }

    func conversation(for indexPath: IndexPath) -> Conversation? {
        return convo.wrappedValue.object(at: indexPath.row)
    }

    func fetchUserProfile() {
        NetworkManager.shared.fetchUserProfile { (users) in
            self.users.wrappedValue = users
        }
    }

    func startListeningForConversations(_ completion: @escaping ([Conversation]) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: Unify.strings.email) as? String else { return }
        let safeEmail = CommunicationManager.shared.safeEmail(emailAddress: email)

        CommunicationManager.shared.getAllConversations(for: safeEmail) { [weak self] result in
            switch result {
            case .success(let successfulConversation):
                guard !successfulConversation.isEmpty else {
                    print("stops here")
                    return
                }

                self?.convo.wrappedValue = successfulConversation
                print(self?.convo.wrappedValue)

                completion(successfulConversation)

            case .failure(let error):
                print("stops here2")

                print(error.localizedDescription)
            }
        }
    }

   @objc func signout() {
    print("button was clicked")
   }
}
