//
//  LunchListViewModel.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit



class LunchListViewModel: NSObject {
    
    enum State{
        case LOADING
        case LOADED
        case WITH_ERROR
    }

    var restaurants:[LunchTableCellViewModel]?
    var error:RemoteRepository.RemoteError?
    var state:State = .LOADING
    
    
    func load(vc: LunchListTableViewController){
        
        RemoteRepository.shared.getRestaurants { restaurants, error in
            self.error = error
            
            if let _restaurants = restaurants{
                
                var stack:[LunchTableCellViewModel] = []

                for i in _restaurants{
                    
                    RemoteRepository.shared.getImage(url: i.backgroundImageURL) { image, error in
                        stack.append(.init(title: i.name, subtitle: i.category, image: image))
                        
                        if(stack.count == _restaurants.count){
                            self.restaurants = stack
                            
                            DispatchQueue.main.async {
                                vc.update()
                            }
                            
                        }
                        
                    }
                    
                    
                    
                }
                
            }
        }
        
    }
    
}


