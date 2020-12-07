//
//  User+CoreDataProperties.swift
//  Pimper
//
//  Created by Will morris on 11/4/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}

extension User : Identifiable {

}
