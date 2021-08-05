//
//  LunchListTableViewController.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit
import SwiftUI

class LunchListTableViewController: UITableViewController {

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
    
    //MARK: - Public methods
    
    func update() {
        indicatorView.stopAnimating()
        self.tableView.reloadData()
    }

    
    //MARK: - Private methods
    
    private func setup(){
        tableView.register(LunchTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundView = indicatorView
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
    private func initViewModel(){
        indicatorView.startAnimating()
        viewModel.load(vc: self)
    }


}

// MARK: - UITableViewDataSource

extension LunchListTableViewController{
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.restaurants?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? LunchTableViewCell else {
            fatalError()
        }
        
        cell.viewModel = viewModel.restaurants?[indexPath.row]
        
        return cell
        
    }
}

// MARK: - UITableViewDelegate

extension LunchListTableViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let index = sender as? IndexPath else {return}
        
        
        
        
        guard let vc = segue.destination as? LunchDetailViewController else{return}
        
        
        
        vc.viewmodel = viewModel.getViewModelAtPos(pos: index.row)
        
    }
}
