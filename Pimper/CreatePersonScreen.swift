//
//  CreatePersonScreen.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit

class CreatePersonScreen: UIViewController {
    
    //###############################################################################################################
    // MARK: - PROPERTIES
    //###############################################################################################################
    
    var coordinator: MainCoordinator
    
    private lazy var firstNameTextField: UITextField = {
        let result = UITextField()
        result.placeholder = "First name..."
        result.delegate = self
        result.returnKeyType = .done
        result.clearButtonMode = UITextField.ViewMode.whileEditing
        result.borderStyle = UITextField.BorderStyle.roundedRect
        return result
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let result = UITextField()
        result.placeholder = "Last name..."
        result.delegate = self
        result.returnKeyType = .done
        result.clearButtonMode = UITextField.ViewMode.whileEditing
        result.borderStyle = UITextField.BorderStyle.roundedRect
        return result
    }()
    
    //###############################################################################################################
    // MARK: - LIFECYCLE
    //###############################################################################################################
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupTextFields()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //###############################################################################################################
    // MARK: - METHODS
    //###############################################################################################################
    
    private func setupTextFields() {
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
       // firstNameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 12).isActive = true
        lastNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        //lastNameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupNavBar() {
        navigationItem.title = "Create"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        // create pop vc save context
    }
}

//###############################################################################################################
// MARK: - EXTENSIONS
//###############################################################################################################

extension CreatePersonScreen: UITextFieldDelegate {

}
