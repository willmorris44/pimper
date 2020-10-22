//
//  MainCoordinator.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit

class MainCoordinator {
    
    let presentingVC: UIViewController
    
    init() {
        let home = UINavigationController(rootViewController: HomeScreen())
        let profile = UINavigationController(rootViewController: ProfileScreen())
        let tabBar = MainTabBar()
        
        tabBar.setViewControllers([home, profile], animated: true)
        
        self.presentingVC = tabBar
    }
}
