//
//  StudyYearData.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 07/11/2020.
//

import Foundation


class StudyYearData {
    class func yearArray() -> [StudyYear] {
        var yearArray = [StudyYear]()
        yearArray.append(StudyYear(year: "First Year"))
        yearArray.append(StudyYear(year: "Second Year"))
        yearArray.append(StudyYear(year: "Third Year"))
        yearArray.append(StudyYear(year: "Fourth Year +"))
        return yearArray
    }
}
