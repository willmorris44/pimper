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
    
    weak var coordinator: MainCoordinator?
        
    private lazy var textFields: [UITextField] = [firstNameTextField, lastNameTextField, ageTextField, addressTextField, numberTextField, instagramTextField, twitterTextField, tiktokTextField, snapchatTextField]
    
    private var selectedIndex: Int?
    
    private lazy var firstNameTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "First name"
        result.delegate = self
        return result
    }()
    
    private lazy var lastNameTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "Last name"
        result.delegate = self
        return result
    }()
    
    private lazy var ageTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "Age"
        result.delegate = self
        result.keyboardType = .numberPad
        return result
    }()
    
    private lazy var numberTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "Number"
        result.delegate = self
        result.keyboardType = .numberPad
        return result
    }()
    
    private lazy var instagramTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "Instagram"
        result.delegate = self
        return result
    }()
    
    private lazy var twitterTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "Twitter"
        result.delegate = self
        return result
    }()
    
    private lazy var snapchatTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "Snapchat"
        result.delegate = self
        result.returnKeyType = .done
        return result
    }()
    
    private lazy var tiktokTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "Tiktok"
        result.delegate = self
        return result
    }()
    
    private lazy var addressTextField: FormTextField = {
        let result = FormTextField()
        result.placeholder = "Address"
        result.delegate = self
        return result
    }()
    
    private lazy var createButton: FloatingButton = {
        let result = FloatingButton { [weak self] in
            self?.createButtonTapped()
        }
        result.setTitle("Create", for: .normal)
        result.backgroundColor = .magenta
        result.tintColor = .white
        return result
    }()
    
    //###############################################################################################################
    // MARK: - LIFECYCLE
    //###############################################################################################################
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        hideKeyboardWhenTappedAround()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Create Person Screen: DEINIT")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupNameTextFields()
        setupPITextFields()
        setupSocialTextFields()
        setupCreateButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //###############################################################################################################
    // MARK: - METHODS
    //###############################################################################################################
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let selectedIndex = selectedIndex {
            let textField = textFields[selectedIndex]
            if keyboardSize.height > (view.frame.height - textField.frame.maxY) {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    guard let self = self else { return }
                    self.view.frame.origin.y = -(keyboardSize.height - (self.view.frame.height - textField.frame.maxY))
                }
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        selectedIndex = nil
    }
    
    private func setupNavBar() {
        navigationItem.title = "Create"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func createButtonTapped() {
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let age = ageTextField.text, let unwrappedAge = Int(age), !firstName.isEmpty && !lastName.isEmpty {
            PersonService.shared.createPerson(firstName: firstName, lastName: lastName, age: unwrappedAge, address: addressTextField.text, number: numberTextField.text, instagram: instagramTextField.text, twitter: twitterTextField.text, tiktok: tiktokTextField.text, snapchat: snapchatTextField.text)
            coordinator?.popScreen(from: self)
        } else {
            let alert = Alert.general(title: "Missing fields", message: "First name, last name, and age are required.")
            present(alert, animated: true)
        }
    }
    
    private func setupCreateButton() {
        view.addSubview(createButton)
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        createButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
    }
    
    private func setupNameTextFields() {
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 8).isActive = true
        lastNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupPITextFields() {
        view.addSubview(ageTextField)
        view.addSubview(addressTextField)
        
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ageTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 8).isActive = true
        ageTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addressTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 8).isActive = true
        addressTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupSocialTextFields() {
        view.addSubview(numberTextField)
        view.addSubview(instagramTextField)
        view.addSubview(twitterTextField)
        view.addSubview(tiktokTextField)
        view.addSubview(snapchatTextField)
        
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 8).isActive = true
        numberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        instagramTextField.translatesAutoresizingMaskIntoConstraints = false
        instagramTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instagramTextField.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 8).isActive = true
        instagramTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        twitterTextField.translatesAutoresizingMaskIntoConstraints = false
        twitterTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        twitterTextField.topAnchor.constraint(equalTo: instagramTextField.bottomAnchor, constant: 8).isActive = true
        twitterTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        tiktokTextField.translatesAutoresizingMaskIntoConstraints = false
        tiktokTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tiktokTextField.topAnchor.constraint(equalTo: twitterTextField.bottomAnchor, constant: 8).isActive = true
        tiktokTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        snapchatTextField.translatesAutoresizingMaskIntoConstraints = false
        snapchatTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        snapchatTextField.topAnchor.constraint(equalTo: tiktokTextField.bottomAnchor, constant: 8).isActive = true
        snapchatTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
}

//###############################################################################################################
// MARK: - EXTENSIONS
//###############################################################################################################

extension CreatePersonScreen: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let index = textFields.firstIndex(of: textField) {
            selectedIndex = index
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        } else {
            if let index = textFields.firstIndex(of: textField) {
                let nextTextField = textFields[index + 1]
                nextTextField.becomeFirstResponder()
            }
        }
        return true
    }
}
