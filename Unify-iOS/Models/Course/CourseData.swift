//
//  CourseData.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 28/10/2020.
//

import Foundation

class CourseData: NSObject {

    class func courseArray() -> [Course] {
        var allCourseData = [Course]()
        allCourseData.append(Course(name: "Accounting & Finance"))
        allCourseData.append(Course(name: "Archaeology"))
        allCourseData.append(Course(name: "Architecture"))
        allCourseData.append(Course(name: "Art & Design"))
        allCourseData.append(Course(name: "Chemical Engineering"))
        allCourseData.append(Course(name: "Civil Engineering"))
        allCourseData.append(Course(name: "Computer Science"))
        allCourseData.append(Course(name: "Economics"))
        allCourseData.append(Course(name: "Electrical & Electronic Engineering"))
        allCourseData.append(Course(name: "French"))
        allCourseData.append(Course(name: "Marketing"))
        allCourseData.append(Course(name: "Nursing"))
        allCourseData.append(Course(name: "Politics"))
        allCourseData.append(Course(name: "Psychology"))
        allCourseData.append(Course(name: "Social Work"))
        allCourseData.append(Course(name: "Sociology"))
        allCourseData.append(Course(name: "Sports Science"))
        allCourseData.append(Course(name: "Youth Work"))
        return allCourseData
    }
}
