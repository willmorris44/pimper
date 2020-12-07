//
//  CreateDateViewController.swift
//  Pimper
//
//  Created by Will morris on 11/5/20.
//

import UIKit
import RxSwift
import RxCocoa

class CreateDateViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    let disposeBag = DisposeBag()
    
    private var tableViewLastTranslation: CGFloat = 0
    
    private var tableViewContentOffset: CGFloat = 0
    
    private lazy var modalView: ModalView = {
        let result = ModalView(with: [.half, .full]) { [weak self] state in
            if state == .full {
                self?.tableView.isScrollEnabled = true
            } else {
                self?.tableView.isScrollEnabled = false
            }
        }
        return result
    }()
    
    private lazy var tableView: UITableView = {
        let result = UITableView()
        result.register(PersonTableViewCell.self, forCellReuseIdentifier: Cells.personCell)
        result.separatorStyle = .none
        result.delaysContentTouches = false
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.numberOfLines = 2
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
         
        setupTitleLabel()
        view.addSubview(modalView)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.cyan.cgColor, UIColor.blue.cgColor]
        gradient.locations = [0, 0.5]
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0.7, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)

        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupTableView() {
        let personsListViewModel = PersonsListViewModel()
        
        if modalView.state == .half {
            tableView.isScrollEnabled = false
        }
        
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        
        modalView.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 48).isActive = true
        tableView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: modalView.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: modalView.bottomAnchor).isActive = true
        
        personsListViewModel.fetchPersonViewModels().observeOn(MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: Cells.personCell, cellType: PersonTableViewCell.self)) { index, viewModel, cell in
            cell.set(person: viewModel)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(PersonViewModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            print("Selected: \(model)")
        }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Who is the \n date with?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
    }
}

// TODOOO I CANT FIGURE OUT  ON HOW TO GET THIS TO WORK

extension CreateDateViewController: UIScrollViewDelegate {
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let gesture = tableView.gestureRecognizers?.first { $0 is UIPanGestureRecognizer } as! UIPanGestureRecognizer
        var translation = gesture.translation(in: view).y
        if translation > 0 && tableView.contentOffset.y <= 0 && translation != tableViewLastTranslation && modalView.state == .full {
            translation -= tableViewContentOffset
            let newTranslation = CGPoint(x: 0, y: (translation - tableViewContentOffset))
            //gesture.setTranslation(newTranslation, in: view)
            modalView.substitueGesture(with: gesture, offset: tableViewContentOffset)
            //modalView.setHeightConstant(with: translation)
            tableViewLastTranslation = translation + tableViewContentOffset
            tableView.contentOffset.y = -1
        }

        if tableViewLastTranslation > 0 {
            tableView.contentOffset.y = -1
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let gesture = tableView.gestureRecognizers?.first { $0 is UIPanGestureRecognizer } as! UIPanGestureRecognizer
        var translation = gesture.translation(in: view).y
        if translation > 0 && tableView.contentOffset.y < 0 {
            modalView.substitueGesture(with: gesture, offset: nil)
        }
        //modalView.finishSettingHeightConstant()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tableViewContentOffset = tableView.contentOffset.y
        tableViewLastTranslation = 0
    }
}
