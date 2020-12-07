//
//  QCDate+CoreDataProperties.swift
//  Pimper
//
//  Created by Will morris on 11/4/20.
//
//

import Foundation
import CoreData


extension QCDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QCDate> {
        return NSFetchRequest<QCDate>(entityName: "QCDate")
    }

    @NSManaged public var address: String?
    @NSManaged public var note: String?
    @NSManaged public var time: DateInterval?
    @NSManaged public var title: String?
    @NSManaged public var person: Person?

}

extension QCDate : Identifiable {

}
