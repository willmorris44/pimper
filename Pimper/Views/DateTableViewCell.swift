//
//  DateTableViewCell.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit

class DateTableViewCell: UITableViewCell {
    
    private(set) var date: QCDateVM?
        
    private lazy var dateLabel: UILabel = {
        let result = UILabel()
        result.text = date?.date
        return result
    }()
    
    private lazy var nameLabel: UILabel = {
        let result = UILabel()
        result.text = date?.person
        return result
    }()
    
    private lazy var addressLabel: UILabel = {
        let result = UILabel()
        result.text = date?.address
        return result
    }()
            
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDate(date: QCDateVM) {
        self.date = date
        addSubview(dateLabel)
        addSubview(nameLabel)
        addSubview(addressLabel)
        
        configureLabels()
        setLabelConstraints()
    }
    
    private func configureLabels() {
        dateLabel.numberOfLines = 0
        dateLabel.adjustsFontSizeToFitWidth = true
        
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        
        addressLabel.numberOfLines = 0
        addressLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12).isActive = true
        nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12).isActive = true
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12).isActive = true
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
        addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
    }
}
