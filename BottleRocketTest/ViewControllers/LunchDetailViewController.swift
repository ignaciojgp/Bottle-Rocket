//
//  LunchDetailViewController.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 04/08/21.
//

import UIKit

class LunchDetailViewController: UIViewController {
    
    //MARK: - Properties

    public var viewModel: LunchDetailViewViewModel?
    
    //MARK: - init

    override func viewDidLoad() {

        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Private methods

    private func configure(){
        
        guard let detailView = self.view as? LunchDetailView else {return}
        detailView.viewmodel = self.viewModel
        
    }
     

}
