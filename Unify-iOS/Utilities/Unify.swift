//
//  Unify.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 19/10/2020.
//

import UIKit
import Floaty
import SearchTextField

class Unify {
    static let strings = Strings()
}

extension Array {
    func object(at index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
