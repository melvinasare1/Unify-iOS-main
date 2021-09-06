//
//  AccountManager.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 26/12/2020.
//

import FirebaseAuth
import FirebaseDatabase
import Observable

class AccountManager {
    
    static let account = AccountManager()
    var users: MutableObservable<[User]>
    let currentUser = Auth.auth().currentUser
    let defaults = UserDefaults.standard
    
    init() {
        users = MutableObservable(wrappedValue: [])
    }
    
    func storeUniversity(universityName: String) {
        defaults.setValue(universityName, forKey: "universityName")
    }

    func updateCurrentUser(userName: String, userAvatar: URL) {
        let changeProfile = Auth.auth().currentUser?.createProfileChangeRequest()
        changeProfile?.displayName = userName
        changeProfile?.photoURL = userAvatar
    }
    
    func deleteUsersAccount() {
        currentUser?.delete(completion: { error in
            if error != nil {
                // Error cannot be deleted
            } else {
                // Account deleted.
            }
        })
    }
    
    func reAuthenticateUser(with credential: AuthCredential) {
        currentUser?.reauthenticate(with: credential) { error, _  in
            if error != nil {
                // An error happened.
            } else {
                // User re-authenticated.
            }
        }
    }
    
    func checkIfUsersLoggedIn(_ compeltion: @escaping (FirebaseAuth.User?, UnifyErrors?)-> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                compeltion(nil, .notSignedIn)
            } else {
                compeltion(user, nil)
            }
        }
    }

    func signout() { // Sort out this function
        do {
            try Auth.auth().signOut()
        } catch let logoutError as NSError {
            print(logoutError)
        }
    }
    
    func resetUserPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
        }
    }
    
    func confirmPasswordReset(code: String, newPassword: String) {
        Auth.auth().confirmPasswordReset(withCode: code, newPassword: newPassword) { (error) in
            print("do something if error")
        }
    }
    
    func verifyPasswordResetCode(code: String) {
        Auth.auth().verifyPasswordResetCode(code) { (code, error) in
            print("do something if error")
        }
    }
}
