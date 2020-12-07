//
//  HomeScreen.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit

class HomeScreen: UIViewController {
    
//###############################################################################################################
// MARK: - PROPERTIES
//###############################################################################################################
    
    weak var coordinator: MainCoordinator?
    
    private lazy var tableView: UITableView = {
        let result = UITableView()
        result.register(DateTableViewCell.self, forCellReuseIdentifier: Cells.dateTableViewCell)
        return result
    }()
    
    private lazy var createDateButton: FloatingButton = {
        let result = FloatingButton { [weak self] in
            guard let self = self else { return }
            self.coordinator?.toCreateDateScreen(from: self)
        }
        result.setImage(UIImage(systemName: "plus"), for: .normal)
        return result
    }()
    
//###############################################################################################################
// MARK: - LIFECYCLE
//###############################################################################################################
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupTableView()
        setupCreateDateButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//###############################################################################################################
// MARK: - METHODS
//###############################################################################################################
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setupNavBar() {
        navigationItem.title = "Home"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupCreateDateButton() {
        view.addSubview(createDateButton)
        
        createDateButton.translatesAutoresizingMaskIntoConstraints = false
        createDateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        createDateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        createDateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.24).isActive = true
        createDateButton.heightAnchor.constraint(equalTo: createDateButton.widthAnchor, multiplier: 1).isActive = true
    }
}

//###############################################################################################################
// MARK: - EXTENSIONS
//###############################################################################################################

extension HomeScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.dateTableViewCell, for: indexPath) as! DateTableViewCell
        //let date = DateViewModel(date: QCDate())
        //cell.setDate(date: date)
        
        return cell 
    }
}
