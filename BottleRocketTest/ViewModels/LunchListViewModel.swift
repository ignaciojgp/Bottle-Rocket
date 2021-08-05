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
    
    private var original_restaurants: [Restaurant]?
    
    ///Load the lunch data and return an array of LunchTableCellViewModel
    func load(vc: LunchListTableViewController){
        
        RemoteRepository.shared.getRestaurants { restaurants, error in
            self.error = error
            
            guard let _restaurants = restaurants else {
                vc.update()
                return
            }
            
            var stack:[LunchTableCellViewModel] = []
            
            for i in _restaurants{
                
                self.original_restaurants = _restaurants
                
                RemoteRepository.shared.getImage(url: i.backgroundImageURL) { image, error in
                    stack.append(.init(name: i.name, category: i.category, image: image))
                    
                    if(stack.count == _restaurants.count){
                        print("LunchListViewModel: load: all images has been loaded")

                        self.restaurants = stack
                        
                        DispatchQueue.main.async {
                            vc.update()
                        }
                        
                    }
                    
                }
                
            }
            
            
        }
        
    }
    
    /// Return a viewmodel for the detail view
    func getViewModelAtPos(pos:Int)->LunchDetailViewViewModel?{
        
        guard let restaurant = original_restaurants?[pos] else {
            return nil
        }
        
        var data:[String] = []
        
        data.append(restaurant.location.formattedAddress.joined(separator: "\n"))
        
        
        if let contact = restaurant.contact{
            data.append(contact.formattedPhone)

            if let twitter = contact.twitter {
                data.append("@\(twitter)")
            }
            
            if let facebook = contact.facebookUsername {
                data.append("@\(facebook)")
            }
            
        }
        
        
        return .init(
            name: restaurant.name,
            category: restaurant.category,
            location_long: restaurant.location.lng,
            location_lat: restaurant.location.lat,
            data: data
        )
    }
    
}



struct LunchTableCellViewModel {
    
    var name:String
    var category:String
    var image:UIImage?
    
}

struct LunchDetailViewViewModel{

    var name:String
    var category:String
    var location_long:Double
    var location_lat:Double
    var data:[String]

}
