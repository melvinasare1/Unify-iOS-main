//
//  User.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 28/10/2020.
//

import Foundation

struct User {
    var name: String
    var email: String
    var profile_picture_url: String
    var toId: String?
    var is_Online: Bool?

    var university: University
    var course: Course
    var studyYear: StudyYear
}
