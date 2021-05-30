//
//  UniversityData.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 28/10/2020.
//

import UIKit

class UniversityData {

    let uuid = UUID()

    class func allUniversityData() -> [University] {
        var universityArrayOne = [University]()
        universityArrayOne.append(University(name: "University of East London", location: "London", picture: ""))
        universityArrayOne.append(University(name: "Imperial College London", location: "London", picture: ""))
        universityArrayOne.append(University(name: "University of London", location: "London" , picture: ""))
        universityArrayOne.append(University(name: "Kingston University", location: "London", picture: ""))
        universityArrayOne.append(University(name: "Middlesex University", location: "London", picture: ""))
        universityArrayOne.append(University(name: "London Metropolitan University", location: "London", picture: ""))
        universityArrayOne.append(University(name: "University of Greenwich", location: "London", picture: ""))
        universityArrayOne.append(University(name: "London South Bank University", location: "London", picture: ""))
        universityArrayOne.append(University(name: "Brunel University", location: "London", picture: ""))
        universityArrayOne.append(University(name: "St Mary's University Twickenham", location: "London",picture: ""))
        return universityArrayOne
    }
}

extension UniversityData: Hashable {
    static func ==(lhs: UniversityData, rhs: UniversityData) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
