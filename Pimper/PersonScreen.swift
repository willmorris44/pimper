//
//  PersonScreen.swift
//  Pimper
//
//  Created by Will morris on 10/22/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PersonScreen: UIViewController {
    
    //###############################################################################################################
    // MARK: - PROPERTIES
    //###############################################################################################################
    
    weak var coordinator: MainCoordinator?
    
    let disposeBag = DisposeBag()
    
    private var personsListViewModel: PersonsListViewModel
    
    private lazy var tableView: UITableView = {
        let result = UITableView()
        result.register(PersonTableViewCell.self, forCellReuseIdentifier: Cells.personCell)
        result.separatorStyle = .none
        result.delaysContentTouches = false
        return result
    }()
    
    //###############################################################################################################
    // MARK: - LIFECYCLE
    //###############################################################################################################
    
    init(coordinator: MainCoordinator, personsListViewModel: PersonsListViewModel) {
        self.coordinator = coordinator
        self.personsListViewModel = personsListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Person Screen: DEINIT")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        setupNavBar()
    }
    
    //###############################################################################################################
    // MARK: - METHODS
    //###############################################################################################################
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        personsListViewModel.fetchPersonViewModels().observeOn(MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: Cells.personCell, cellType: PersonTableViewCell.self)) { index, viewModel, cell in
            cell.set(person: viewModel)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(PersonViewModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            self.coordinator?.toPersonDetailScreen(from: self, with: model)
        }).disposed(by: disposeBag)
        
        tableView.rx.modelDeleted(PersonViewModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            self.personsListViewModel.deletePerson(with: model)
        }).disposed(by: disposeBag)
    }
    
    private func setupNavBar() {
        navigationItem.title = personsListViewModel.title
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        if let coordinator = coordinator {
            coordinator.toCreatePersonScreen(from: self)
        }
    }
}

//###############################################################################################################
// MARK: - EXTENSIONS
//###############################################################################################################

//extension PersonScreen: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return PersonService.shared.persons?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.personCell, for: indexPath) as? PersonTableViewCell
//        if let person = PersonService.shared.persons?[indexPath.row] {
//            cell?.setPerson(person)
//        }
//        cell?.selectionStyle = .none
//
//        return cell ?? UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
//            if let personToRemove = PersonService.shared.persons?[indexPath.row] {
//                PersonService.shared.deletePerson(personToRemove)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let person = PersonService.shared.persons?[indexPath.row] {
//            coordinator?.toPersonDetailScreen(from: self, with: person)
//        }
////            tabBarController?.setTabBarHidden(true, animated: true)
////            navigationController?.navigationBar.layer.zPosition = -1
//    }
//}
