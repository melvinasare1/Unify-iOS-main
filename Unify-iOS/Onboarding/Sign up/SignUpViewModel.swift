//
//  SignUpViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 04/11/2020.
//

import Foundation

class SignupViewModel { 


    func createUserWithEmail(email: String, password: String, _ completion: @escaping (String) -> Void) {
        NetworkManager.shared.createUserWithEmail(email: email, password: password) { result in
            completion(result.user.uid)
        }
    }
}
