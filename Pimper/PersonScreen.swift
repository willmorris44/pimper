//
//  PersonScreen.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit

class PersonScreen: UIViewController {
    
    //###############################################################################################################
    // MARK: - PROPERTIES
    //###############################################################################################################
    
    var coordinator: MainCoordinator
    
    private lazy var tableView: UITableView = {
        let result = UITableView()
        result.register(DateTableViewCell.self, forCellReuseIdentifier: Cells.dateCell)
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
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
        navigationItem.title = "Persons"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        coordinator.toCreateScreen(from: self)
    }
}

//###############################################################################################################
// MARK: - EXTENSIONS
//###############################################################################################################

extension PersonScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.dateCell, for: indexPath) as! DateTableViewCell
        let date = QCDateVM()
        cell.setDate(date: date)
        
        return cell
    }
}
