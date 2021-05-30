//
//  ObjectSavable.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import Foundation

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
