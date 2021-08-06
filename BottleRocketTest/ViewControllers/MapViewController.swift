//
//  MapViewController.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 05/08/21.
//

import UIKit

class MapViewController: UIViewController {
    //MARK: - Priperties
    
    var viewModel: LunchListViewModel?{
        didSet{
            configure()
        }
    }
    
    //MARK: - Init
    
    override func viewDidLoad() {

        super.viewDidLoad()
        configure()

    }
    
    //MARK: - Private methods
    
    private func configure(){
        
        guard let mapview = self.view as? MapView else {return}
        mapview.viewmodel = self.viewModel?.getMapViewModel()
    }
    
 }
