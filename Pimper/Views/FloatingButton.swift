//
//  FloatingButton.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit

class FloatingButton: UIButton {
    
    private var completion: () -> Void
    
    init(_ completion: @escaping () -> Void) {
        self.completion = completion
        
        super.init(frame: .zero)

        addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapped() {
        completion()
    }
    
    private func setupSelf() {
        backgroundColor = .white
        tintColor = .black
    }
    
    private func configureSelf() {
        //clipsToBounds = true
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = UIColor.systemGray4.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSelf()
    }
}
