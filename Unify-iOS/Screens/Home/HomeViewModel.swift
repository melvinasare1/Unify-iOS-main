//
//  UsersViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 20/11/2020.
//

import Foundation
import Observable

class HomeViewModel {

    var users: MutableObservable<[User]>

    init() {
        users = MutableObservable(wrappedValue: [])
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

    func fetchUserProfile() {
        NetworkManager.shared.fetchUserProfile { (users) in
            self.users.wrappedValue = users
        }
    }

   @objc func signout() {
    print("button was clicked")
   }
}
