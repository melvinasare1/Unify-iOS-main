//
//  LoginViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 04/11/2020.
//

import FirebaseAuth

class LoginViewModel {

    func signinWithEmail(email: String, password: String,_ completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.signInWithEmail(email: email, password: password) { success in
            completion(success)
        }
    }
}
