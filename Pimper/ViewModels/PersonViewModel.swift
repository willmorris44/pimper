//
//  PersonViewModel.swift
//  Pimper
//
//  Created by Will morris on 11/2/20.
//

import Foundation
import CoreData
import RxSwift
import RxRelay

class PersonViewModel {
    
    private let person: BehaviorRelay<Person>
    private let disposeBag = DisposeBag()
        
    var displayName: String?
    
    var displayDistance: String?
    
    var model: Person {
        return person.value
    }
    
    init(person: Person) {
        self.person = BehaviorRelay(value: person)
        
        self.person.asObservable().subscribeOn(MainScheduler.instance).subscribe(onNext: { value in
            self.displayName = "\(value.firstName!) \(value.lastName!), \(String(value.age))"
            self.displayDistance = "80 Miles"
        }).disposed(by: disposeBag)
    }
    
//    func fetchDateViewModels() -> Observable<[DateViewModel]> {
//        return Observable.create { (observer) -> Disposable in
//
//        }
//    }
    
    func fetchDateViewModels() -> Observable<[DateViewModel]> {
        person.asObservable().map { $0.dates.map { ($0 as NSOrderedSet).map { DateViewModel(date: ($0 as! QCDate)) } }! }
    }
}
