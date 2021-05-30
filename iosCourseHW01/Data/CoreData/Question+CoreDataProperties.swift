//
//  Question+CoreDataProperties.swift
//  
//
//  Created by Ivan Skorupan on 30.05.2021..
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "Question")
    }

    @NSManaged public var id: Int16
    @NSManaged public var question: String?
    @NSManaged public var answers: [String]?
    @NSManaged public var correctAnswer: Int16
    @NSManaged public var quiz: CDQuiz?

}
