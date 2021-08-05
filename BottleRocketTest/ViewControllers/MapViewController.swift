//
//  MapViewController.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 05/08/21.
//

import UIKit

class MapViewController: UIViewController {

    var viewModel: LunchListViewModel?{
        didSet{
            configure()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure(){
        
        guard let mapview = self.view as? MapView else {return}
        
        mapview.viewmodel = self.viewModel?.getMapViewModel()
        
        
        
    }
    
 }
