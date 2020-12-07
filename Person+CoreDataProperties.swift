//
//  Person+CoreDataProperties.swift
//  Pimper
//
//  Created by Will morris on 11/4/20.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var address: String?
    @NSManaged public var age: Int64
    @NSManaged public var firstName: String?
    @NSManaged public var instagram: String?
    @NSManaged public var lastName: String?
    @NSManaged public var number: String?
    @NSManaged public var school: String?
    @NSManaged public var snapchat: String?
    @NSManaged public var tiktok: String?
    @NSManaged public var twitter: String?
    @NSManaged public var work: String?
    @NSManaged public var dates: NSOrderedSet?
    @NSManaged public var notes: NSOrderedSet?
    @NSManaged public var infoGrabbers: NSOrderedSet?

}

// MARK: Generated accessors for dates
extension Person {

    @objc(addDatesObject:)
    @NSManaged public func addToDates(_ value: QCDate)

    @objc(removeDatesObject:)
    @NSManaged public func removeFromDates(_ value: QCDate)

    @objc(addDates:)
    @NSManaged public func addToDates(_ values: NSSet)

    @objc(removeDates:)
    @NSManaged public func removeFromDates(_ values: NSSet)

}

// MARK: Generated accessors for notes
extension Person {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

// MARK: Generated accessors for infoGrabbers
extension Person {

    @objc(addInfoGrabbersObject:)
    @NSManaged public func addToInfoGrabbers(_ value: InfoGrabber)

    @objc(removeInfoGrabbersObject:)
    @NSManaged public func removeFromInfoGrabbers(_ value: InfoGrabber)

    @objc(addInfoGrabbers:)
    @NSManaged public func addToInfoGrabbers(_ values: NSSet)

    @objc(removeInfoGrabbers:)
    @NSManaged public func removeFromInfoGrabbers(_ values: NSSet)

}

extension Person : Identifiable {

}
