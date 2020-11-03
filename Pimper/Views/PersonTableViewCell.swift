//
//  PersonTableViewCell.swift
//  Pimper
//
//  Created by Will morris on 10/26/20.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    private(set) var person: PersonViewModel?
    
    private lazy var nameLabel: UILabel = {
        let result = UILabel()
        result.textColor = .magenta
        return result
    }()
    
    private lazy var distanceLabel: UILabel = {
        let result = UILabel()
        result.textColor = .lightGray
        return result
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10))
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            shrink(down: true)
        } else {
            shrink(down: false)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        if selected {
           // expandToFullScreen()
        }
    }
    
    func set(person: PersonViewModel) {
        self.person = person
        
        setupView()
        setupLabels()
        selectionStyle = .none
    }
    
    private func expandToFullScreen() {
        guard let globalPoint = superview?.convert(frame.origin, to: nil) else { return }
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.contentView.frame = CGRect(x: 0 - globalPoint.x, y: 0 - globalPoint.y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            self.contentView.layer.cornerRadius = 0
            self.contentView.layer.shadowOpacity = 0
            self.layer.zPosition = 1
        }
    }
    
    private func shrink(down: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if down {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } else {
                self.transform = .identity
            }
        }
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.shadowColor = UIColor.systemGray2.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.backgroundColor = .white
        
    }
    
    private func setupLabels() {
        addSubview(nameLabel)
        addSubview(distanceLabel)
        
        nameLabel.text = person?.displayName
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 17).isActive = true
        
        distanceLabel.text = person?.displayDistance
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
        distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22).isActive = true
    }
}
