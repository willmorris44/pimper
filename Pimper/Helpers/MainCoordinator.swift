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
        let tabBar = MainTabBar()
        self.presentingVC = tabBar

        let homeVC = HomeScreen()
        let profileVC = ProfileScreen()
        let personsVC = PersonScreen(coordinator: self)
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        let personsNC = UINavigationController(rootViewController: personsVC)
        
        tabBar.setViewControllers([homeNC, personsNC, profileNC], animated: true)
    }
    
    func toCreateScreen(from vc: UIViewController) {
        let newVC = CreatePersonScreen(coordinator: self)
        vc.navigationController?.pushViewController(newVC, animated: true)
    }
}
