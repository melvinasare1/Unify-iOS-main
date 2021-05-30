//
//  UserDefaults+Extensions.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 13/05/2021.
//

import UIKit

extension UserDefaults: ObjectSavable {

    enum UserLoggedInState: String {
        case isLoggedIn
    }

    func setIsLoggedIn(value: Bool) {
        UserDefaults.standard.set(false, forKey: UserLoggedInState.isLoggedIn.rawValue)
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: UserLoggedInState.isLoggedIn.rawValue)
    }

    func saveUserName(name: String) {
        UserDefaults.standard.set(name, forKey: "Name")
    }

    func saveUserAvatar(avatar: UIImageView) {
        UserDefaults.standard.set(avatar, forKey: "avatar")
    }

    func saveAllUserData(id: String, university: String, course: String, year: String) {
        UserDefaults.standard.set(id, forKey: "id")
        UserDefaults.standard.set(university, forKey: "university")
        UserDefaults.standard.set(course, forKey: "course")
        UserDefaults.standard.set(year, forKey: "year")
    }

    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw UnifyErrors.unableToEncode
        }
    }

    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw UnifyErrors.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw UnifyErrors.unableToDecode
        }
    }
}
