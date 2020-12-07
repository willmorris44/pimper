//
//  DatesView.swift
//  Pimper
//
//  Created by Will morris on 11/3/20.
//

import UIKit
import RxSwift
import RxCocoa

class DatesView: UIView {
    
    let person: PersonViewModel
    
    let disposeBag = DisposeBag()
    
    private lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.text = "Dates"
        result.font = UIFont.boldSystemFont(ofSize: 18)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let result = UICollectionView(frame: .zero, collectionViewLayout: layout)
        result.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: Cells.dateCollectionViewCell)
        result.backgroundColor = .white
        result.translatesAutoresizingMaskIntoConstraints = false
        result.showsHorizontalScrollIndicator = false
        return result
    }()
    
    init(person: PersonViewModel) {
        self.person = person
        super.init(frame: .zero)
        
        setupTitle()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitle() {
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        person.fetchDateViewModels().asDriver(onErrorJustReturn: []).drive(collectionView.rx.items(cellIdentifier: Cells.dateCollectionViewCell, cellType: DateCollectionViewCell.self)) { index, viewModel, cell in
            cell.set(date: viewModel)
        }.disposed(by: disposeBag)
    
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension DatesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.height*0.8, height: size.height*0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
