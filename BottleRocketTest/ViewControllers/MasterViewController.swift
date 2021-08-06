//
//  MasterViewController.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 05/08/21.
//

import UIKit



class MasterViewController: UIViewController {
    
    //MARK: - Properties
    
    enum Section {
        case main
    }
    
    let collectionList:UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        return UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout.list(using: configuration))
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    var snapshot: NSDiffableDataSourceSnapshot<Section, String>!
    
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Private methods
    
    private func setup(){
        collectionList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionList)
        
        NSLayoutConstraint.activate([
            collectionList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionList, cellProvider: { collectionview, index, item in
            let cell = collectionview.dequeueConfiguredReusableCell(using: self.categoryCellregistration(), for: index, item: item)
            return cell
        })
        
        snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(["Lunch","Internets"], toSection: .main)
        
        dataSource.apply(snapshot)
        
        collectionList.delegate = self
    }
    
    private func categoryCellregistration() ->
    UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        
        return .init { cell, _, item in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = item
            
            cell.tintColor = UIColor.darkGray
            cell.contentConfiguration = configuration
            
            
        }
    }
    
}

//MARK: - UICollectionViewDelegate

extension MasterViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            performSegue(withIdentifier: "ShowLunch", sender: indexPath)
        }else{
            performSegue(withIdentifier: "ShowWeb", sender: indexPath)
        }
    }
    
}
