//
//  InfoGrabber+CoreDataProperties.swift
//  Pimper
//
//  Created by Will morris on 11/4/20.
//
//

import Foundation
import CoreData


extension InfoGrabber {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InfoGrabber> {
        return NSFetchRequest<InfoGrabber>(entityName: "InfoGrabber")
    }

    @NSManaged public var answer: String?
    @NSManaged public var question: String?
    @NSManaged public var person: Person?

}

extension InfoGrabber : Identifiable {

}
