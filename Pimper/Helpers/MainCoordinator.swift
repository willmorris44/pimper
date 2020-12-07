//
//  MainCoordinator.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit

class MainCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBar = MainTabBar()

        let homeVC = HomeScreen(coordinator: self)
        let profileVC = ProfileScreen()
        let personsVC = PersonScreen(coordinator: self, personsListViewModel: PersonsListViewModel())
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        let personsNC = UINavigationController(rootViewController: personsVC)
        
        tabBar.setViewControllers([homeNC, personsNC, profileNC], animated: true)
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
    
    func toCreatePersonScreen(from vc: UIViewController) {
        weak var weakVC = vc
        let newVC = CreatePersonScreen(coordinator: self)
        weakVC!.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func toCreateDateScreen(from vc: UIViewController) {
        weak var weakVC = vc
        let newVC = CreateDateViewController(coordinator: self)
        weakVC!.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func toPersonDetailScreen(from vc: UIViewController, with person: PersonViewModel) {
        let newVC = PersonDetailScreen(coordinator: self, person: person)
        newVC.modalPresentationStyle = .formSheet
        window.rootViewController!.present(newVC, animated: true)
    }
    
    func popScreen(from vc: UIViewController) {
        weak var weakVC = vc
        weakVC!.navigationController?.popViewController(animated: true)
    }
    
    func signIn(with: User) {
        
    }
}
