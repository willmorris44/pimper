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
//        (UIApplication.shared.delegate as! AppDelegate).deleteAllData("Person")
//        (UIApplication.shared.delegate as! AppDelegate).deleteAllData("QCDate")
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
        
        // test
        let date = QCDate(context: context)
        date.address = "123 address"
        date.time = DateInterval(start: Date(), duration: 123)
        person.addToDates(date)
        
        let date2 = QCDate(context: context)
        date2.address = "839 address"
        date2.time = DateInterval(start: Date(), duration: 323)
        person.addToDates(date2)
        
        let date3 = QCDate(context: context)
        date3.address = "203 address"
        date3.time = DateInterval(start: Date(), duration: 54322)
        person.addToDates(date3)
        
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
