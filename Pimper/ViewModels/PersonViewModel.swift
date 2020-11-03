//
//  PersonViewModel.swift
//  Pimper
//
//  Created by Will morris on 11/2/20.
//

import Foundation

class PersonViewModel {
    
    private let person: Person
    
    var displayName: String {
        return "\(person.firstName!) \(person.lastName!), \(String(person.age))"
    }
    
    var displayDistance: String {
        return "80 miles"
    }
    
    var model: Person {
        return person
    }
    
    init(person: Person) {
        self.person = person
    }
}
