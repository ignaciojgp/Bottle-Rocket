//
//  LunchListTableViewController.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit
import SwiftUI

class LunchListTableViewController: UIViewController {

    //MARK: - Properties
    
    private lazy var viewModel = LunchListViewModel()
    private let indicatorView = UIActivityIndicatorView(style: .large)
    
    
    //MARK: - UIViewController
    
    override func loadView() {
        super.loadView()
         setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "DetailSegue":
            guard let index = sender as? Int else {return}
            guard let vc = segue.destination as? LunchDetailViewController else{return}
            vc.viewModel = viewModel.getViewModelAtPos(pos: index)
        default:
            guard let vc = segue.destination as? MapViewController else{return}
            vc.viewModel = viewModel
        }
        
    }
    
    //MARK: - Public methods
    
    func update() {
        
        guard let listView = view as? LunchListView else {return}
        
        if let error = viewModel.error {
            let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            alert.addAction(.init(title: "Retry", style: .default, handler: { _ in
                self.initViewModel()
            }))
            present(alert, animated: true, completion: nil)
        }else{
            listView.viewModel = viewModel.restaurants
        }
        
        
    }

    
    //MARK: - Private methods
    
    private func setup(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let mapsItem = UIBarButtonItem(image: UIImage(named: "icon_map"), style: .plain, target: self, action: #selector(didTapMap))
        navigationItem.setRightBarButton(mapsItem, animated: true)
        guard let listview = view as? LunchListView else {return}
        
        listview.listener = self
    }
    
    //MARK: - Private methods

    private func initViewModel(){
        indicatorView.startAnimating()
        viewModel.load(vc: self)
    }
    
    //MARK: - Events
    
    @objc private func didTapMap(){
        performSegue(withIdentifier: "showMap", sender: self)
    }
 

}

//MARK: - LunchListViewListener
extension LunchListTableViewController: LunchListViewListener{
    func onTapItem(index: Int) {
        performSegue(withIdentifier: "DetailSegue", sender: index)
    }
}
