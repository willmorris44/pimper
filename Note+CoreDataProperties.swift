//
//  Note+CoreDataProperties.swift
//  Pimper
//
//  Created by Will morris on 11/4/20.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var text: String?
    @NSManaged public var person: Person?

}

extension Note : Identifiable {

}
