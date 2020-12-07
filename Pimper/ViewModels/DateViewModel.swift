//
//  DateViewModel.swift
//  Pimper
//
//  Created by Will morris on 11/3/20.
//

import Foundation
import UIKit
import CoreData

class DateViewModel {
    private let date: QCDate
    
    var displayTime: String {
        return "\(date.time!.start.shortDate))"
    }
    
    var displayAddress: String {
        return date.address ?? "address"
    }
    
    var model: QCDate {
        return date
    }
    
    init(date: QCDate) {
        self.date = date
    }
}
