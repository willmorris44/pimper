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
    
    private lazy var tableView: UITableView = {
        let result = UITableView()
        result.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return result
    }()
    
//###############################################################################################################
// MARK: - LIFECYCLE
//###############################################################################################################
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Home"
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
}

//###############################################################################################################
// MARK: - EXTENSIONS
//###############################################################################################################

extension HomeScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
}
