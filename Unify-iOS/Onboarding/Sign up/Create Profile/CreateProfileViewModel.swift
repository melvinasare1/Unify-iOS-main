//
//  CreateProfileViewModel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 04/11/2020.
//

import UIKit

class CreateProfileViewModel {

    public var userId: String
    public let courseFilter = CourseData.courseArray()
    public let universityFilter = UniversityData.allUniversityData()
    public let studyYearFilter = StudyYearData.yearArray()

    init(userId: String) {
        self.userId = userId
    }
    
    func updateUserProfile(name: String, university_name: String, course: String, yearOfStudy: String, _ completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.addUserToDatabase(userId: userId, name: name,
                                                university_name: university_name,
                                                course: course,
                                                yearOfStudy: yearOfStudy, { success in completion(success) })
        UserDefaults.standard.saveAllUserData(id: userId, university: university_name, course: course, year: yearOfStudy)
    }

    func uploadImageToDatabase(avatarView: UIImageView, userId: String) {
        NetworkManager.shared.uploadImageToFirebaseStorage(avatarView: avatarView, userId: userId)
    }
}
