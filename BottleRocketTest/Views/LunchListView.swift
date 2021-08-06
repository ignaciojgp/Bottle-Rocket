//
//  LunchListView.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 05/08/21.
//

import UIKit

protocol LunchListViewListener {
    func onTapItem(index:Int)->Void
}

class LunchListView: UIView {
    
    enum Section {
        case main
    }
    
    let collectionList:UICollectionView = {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        
        let fullWidthItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/2))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullWidthItem,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        return view
        
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, LunchTableCellViewModel>!
    
    var snapshot: NSDiffableDataSourceSnapshot<Section, LunchTableCellViewModel>!
    
    var viewModel:[LunchTableCellViewModel]?{
        didSet{
            configure()
        }
    }
    
    var listener: LunchListViewListener?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private func setup(){
        
        addSubview(collectionList)
        
        NSLayoutConstraint.activate([
            
            collectionList.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
        dataSource = UICollectionViewDiffableDataSource<Section, LunchTableCellViewModel>(collectionView: collectionList, cellProvider: { collectionview, index, item in
            let cell = collectionview.dequeueConfiguredReusableCell(using: self.categoryCellregistration(), for: index, item: item)
            return cell
        })
       
        collectionList.delegate = self

    }
    
    private func configure(){
        
        guard let items = viewModel else {return}

        snapshot = NSDiffableDataSourceSnapshot<Section, LunchTableCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
        
    }
    
    private func categoryCellregistration() ->
    UICollectionView.CellRegistration<LunchItemViewCell, LunchTableCellViewModel> {
        
        return .init { cell, _, item in
            cell.viewModel = item
            
            
        }
    }
}

extension LunchListView: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        listener?.onTapItem(index: indexPath.row)
        
    }
    
}
