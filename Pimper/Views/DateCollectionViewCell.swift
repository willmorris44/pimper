//
//  DateCollectionViewCell.swift
//  Pimper
//
//  Created by Will morris on 11/3/20.
//

import Foundation
import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    private(set) var date: DateViewModel?
    
    func set(date: DateViewModel) {
        self.date = date
        
        setupView()
    }
    
    private func setupView() {
        
    }
}
