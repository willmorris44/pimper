//
//  MainTabBar.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit

class MainTabBar: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let items = tabBar.items else { return }
        
        let images = ["house", "list.dash", "person.circle"] 
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
            items[i].title = ""
            items[i].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}
