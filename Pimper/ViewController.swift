//
//  ViewController.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let rect = UIButton()
        view.addSubview(rect)
        rect.setTitle("hello", for: .normal)
        rect.backgroundColor = .red
        rect.translatesAutoresizingMaskIntoConstraints = false
        rect.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rect.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }


}

