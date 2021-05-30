//
//  Univerty.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 28/10/2020.
//

import UIKit

struct University {
    let uuid = UUID()

    var name: String
    var location: String
    var picture: String
}

extension University: Hashable {
    static func ==(lhs: University, rhs: University) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
