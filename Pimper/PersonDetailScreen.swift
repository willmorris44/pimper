//
//  PersonDetailScreen.swift
//  Pimper
//
//  Created by Will morris on 10/23/20.
//

import Foundation
import UIKit

class PersonDetailScreen: UIViewController {
    
    //###############################################################################################################
    // MARK: - PROPERTIES
    //###############################################################################################################
    
    weak var coordinator: MainCoordinator?
    var person: PersonViewModel
    
    private lazy var nameLabel: UILabel = {
        let result = UILabel()
        result.text = person.displayName
        result.font = UIFont.boldSystemFont(ofSize: 28)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var personInfoView: PersonInfoView = {
        let result = PersonInfoView(person: person)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    //###############################################################################################################
    // MARK: - LIFECYCLE
    //###############################################################################################################
    
    init(coordinator: MainCoordinator, person: PersonViewModel) {
        self.coordinator = coordinator
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Person Detail Screen: DEINIT")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNameLabel()
        setupPersonInfoView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
    }
    
    //###############################################################################################################
    // MARK: - METHODS
    //###############################################################################################################
    
    private func setupNavBar() {
        navigationItem.title = person.model.firstName
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func editButtonTapped() {
        //todo go to edit screen
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupPersonInfoView() {
        view.addSubview(personInfoView)
        personInfoView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24).isActive = true
        personInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        personInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    }
}
