//
//  UnifyStore.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 26/12/2020.
//

import Foundation

struct UnifyStore {

    let defaults = UserDefaults.standard

    // MARK: - Store


    func storeUniversity(universityName: String) {
        defaults.setValue(universityName, forKey: "universityName")
    }

    func storeUser(user: User) {
        defaults.setValue(user, forKey: "user")
    }



    // MARK: - Get


}


