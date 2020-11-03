//
//  PersonInfoView.swift
//  Pimper
//
//  Created by Will morris on 11/2/20.
//

import UIKit

class PersonInfoView: UIView {
    var person: PersonViewModel
    
    var spacing: CGFloat = 24
    var padding: CGFloat = 18
    var labels: [UILabel] = []
    var titleLabels: [String] = []
    
    private lazy var addressLabel: UILabel = {
        let result = UILabel()
        result.text = person.model.address ?? "N/A"
        return result
    }()
    
    private lazy var numberLabel: UILabel = {
        let result = UILabel()
        result.text = person.model.number ?? "N/A"
        return result
    }()
    
    private lazy var instagramLabel: UILabel = {
        let result = UILabel()
        result.text = person.model.instagram ?? "N/A"
        return result
    }()
    
    private lazy var twitterLabel: UILabel = {
        let result = UILabel()
        result.text = person.model.twitter ?? "N/A"
        return result
    }()
    
    private lazy var tiktokLabel: UILabel = {
        let result = UILabel()
        result.text = person.model.tiktok ?? "N/A"
        return result
    }()
    
    private lazy var snapchatLabel: UILabel = {
        let result = UILabel()
        result.text = person.model.snapchat ?? "N/A"
        return result
    }()
    
    init(person: PersonViewModel) {
        self.person = person
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        var height: CGFloat = spacing
        for label in labels {
            height += (label.frame.height + spacing)
        }
        return CGSize(width: 0, height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        backgroundColor = .white
        
        invalidateIntrinsicContentSize()
    }
    
    private func addSeperators() {
        for label in labels {
            if label != labels.last {
                let seperator = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                seperator.backgroundColor = .lightGray
                addSubview(seperator)
                seperator.translatesAutoresizingMaskIntoConstraints = false
                seperator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: spacing/2).isActive = true
                seperator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
                seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
                seperator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        }
    }
    
    private func setTitleLabels() {
        var index = 0
        for label in labels {
            let title = UILabel()
            title.text = titleLabels[index]
            addSubview(title)
            title.translatesAutoresizingMaskIntoConstraints = false
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
            title.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
            index += 1
        }
    }
    
    private func setLabels() {
        var index = 0
        for label in labels {
            let anchor: NSLayoutAnchor = index != 0 ? labels[index-1].bottomAnchor : topAnchor
            label.textColor = .gray
            addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: anchor, constant: spacing).isActive = true
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
            index += 1
        }
    }
    
    private func setupViews() {
        labels = [addressLabel, numberLabel, instagramLabel, twitterLabel, tiktokLabel, snapchatLabel]
        titleLabels = ["Address", "Number", "Instagram", "Twitter", "Tiktok", "Snapchat"]
        
        setLabels()
        addSeperators()
        setTitleLabels()
    }
}
