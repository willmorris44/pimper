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
    
    private lazy var dateLabel: UILabel = {
        let result = UILabel()
        return result
    }()
    
    private lazy var addressLabel: UILabel = {
        let result = UILabel()
        return result
    }()
    
    func set(date: DateViewModel) {
        self.date = date
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        backgroundColor = .white        
    }
    
    private func setupView() {
        addSubview(dateLabel)
        addSubview(addressLabel)
        
        dateLabel.text = date?.displayTime
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        addressLabel.text = date?.displayAddress
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
    }
}
