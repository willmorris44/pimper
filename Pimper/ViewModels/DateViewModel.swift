//
//  DateViewModel.swift
//  Pimper
//
//  Created by Will morris on 11/3/20.
//

import Foundation
import UIKit

class DateViewModel {
    private let date: QCDate
    
    var displayTime: String {
        return "f"
    }
    
    var displayAddress: String {
        return "d"
    }
    
    var model: QCDate {
        return date
    }
    
    init(date: QCDate) {
        self.date = date
    }
}
