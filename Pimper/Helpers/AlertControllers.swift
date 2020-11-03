//
//  AlertControllers.swift
//  Pimper
//
//  Created by Will morris on 10/23/20.
//

import Foundation
import UIKit

class Alert {
    static func general(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            
        }
        
        alert.addAction(okAction)
        return alert
    }
}
