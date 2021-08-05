//
//  LunchDetailViewController.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 04/08/21.
//

import UIKit

class LunchDetailViewController: UIViewController {
    
    public var viewmodel: LunchDetailViewViewModel?
    
    override func viewDidLoad() {

        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        
        guard let detailView = self.view as? LunchDetailView else {return}
        detailView.viewmodel = self.viewmodel
        
    }
     

}
