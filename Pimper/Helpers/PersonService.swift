//
//  UserController.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit
import CoreData
import RxSwift
import RxRelay

protocol PersonServiceProtocol {
    func fetchPersons() -> Observable<[Person]>
    func createPerson(firstName: String, lastName: String, age: Int, address: String?, number: String?, instagram: String?, twitter: String?, tiktok: String?, snapchat: String?)
}

class PersonService {
    
    static let shared = PersonService()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var user: [User]?
    
    //private(set) persons
    private(set) var persons: BehaviorRelay<[Person]> = BehaviorRelay(value: [])
    
    init() {
        //self.user = [User(context: context)]
        fetchPersons()
        self.fetchUser()
       // self.fetchPersons()
    }
    
    func createPerson(firstName: String, lastName: String, age: Int, address: String?, number: String?, instagram: String?, twitter: String?, tiktok: String?, snapchat: String?) {
        let person = Person(context: context)
        person.firstName = firstName
        person.lastName = lastName
        person.age = Int64(age)
        person.address = address
        person.number = number
        person.instagram = instagram
        person.twitter = twitter
        person.tiktok = tiktok
        person.snapchat = snapchat
        saveContext()
        fetchPersons()
    }
    
    func deletePerson(_ person: Person) {
        context.delete(person)
        saveContext()
        fetchPersons()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    private func fetchUser() {
        do {
            self.user = try context.fetch(User.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func fetchPersons() {
        do {
            let persons = try self.context.fetch(Person.fetchRequest()) as! [Person]
            self.persons.accept(persons)
        } catch {
            print(error)
        }
    }
}
