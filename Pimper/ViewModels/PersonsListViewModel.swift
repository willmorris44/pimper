//
//  PersonsListViewModel.swift
//  Pimper
//
//  Created by Will morris on 11/2/20.
//

import Foundation
import RxSwift
import RxRelay

//enum PersonTableViewCellType {
//    case normal(cellViewModel: PersonCellViewModel)
//    case error(message: String)
//    case empty
//}

class PersonsListViewModel {
    
    let title = "Persons"
    
    func fetchPersonViewModels() -> Observable<[PersonViewModel]> {
        PersonService.shared.persons.asObservable().map { $0.map { PersonViewModel(person: $0) } }
    }
    
    func deletePerson(with person: PersonViewModel) {
        PersonService.shared.deletePerson(person.model)
    }
}
