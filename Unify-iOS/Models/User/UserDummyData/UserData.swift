//
//  UserData.swift
//  Unify-iOS
//
//  Created by melvin asare on 15/01/2021.
//

import UIKit

class UserData {

    class func userDummyData() -> [UserModelDummy] {
        var userArray = [UserModelDummy]()

        userArray.append(UserModelDummy(name: "Jason_sandon", email: "Jason_sandon@gmail.com", profile_picture_url: UIImage(named: "crocker")!, toId: "Jason_sandon", is_Online: true, university: University(name: "London", location: "Lodon", picture: "profileImage1"), course: Course(name: "Business"), studyYear: StudyYear(year: "Year 1")))

        userArray.append(UserModelDummy(name: "Melvin_asare", email: "melvin_asare@gmail.com", profile_picture_url: UIImage(named: "timmy")!, toId: "melvin_asare", is_Online: true, university: University(name: "London", location: "London", picture: "profileImage1"), course: Course(name: "Business"), studyYear: StudyYear(year: "Year 3")))

        userArray.append(UserModelDummy(name: "Michelle_asare", email: "Michelle_asare@gmail.com", profile_picture_url: UIImage(named: "timmy2")!, toId: "Michelle_asare", is_Online: true, university: University(name: "Birmingham", location: "Birmingham", picture: "profileImage1"), course: Course(name: "Nursing"), studyYear: StudyYear(year: "Year 3")))

        userArray.append(UserModelDummy(name: "Charles_altidore", email: "Charles_altidore@gmail.com", profile_picture_url: UIImage(named: "strongguy")!, toId: "Charles_altidore", is_Online: true, university: University(name: "Brighton", location: "Brighton", picture: "profileImage1"), course: Course(name: "Business"), studyYear: StudyYear(year: "Year 1")))

        userArray.append(UserModelDummy(name: "Sarah_Jess", email: "Sarah_Jess@gmail.com", profile_picture_url: UIImage(named: "tootie")!, toId: "Sarah_Jess", is_Online: true, university: University(name: "London", location: "London", picture: "profileImage1"), course: Course(name: "Business"), studyYear: StudyYear(year: "Year 2")))

        return userArray

    }
}
