//
//  LunchListViewModel.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit



class LunchListViewModel: NSObject {
    
    
    var restaurants:[LunchTableCellViewModel]?{
        get{
            return original_restaurants?.map({ Restaurant in
                .init(name: Restaurant.name, category: Restaurant.category, url: Restaurant.backgroundImageURL)
            })
            
        }
    }
    
    var error:RemoteRepository.RemoteError?
    
    
    private var original_restaurants: [Restaurant]?
    
    ///Load the lunch data and return an array of LunchTableCellViewModel
    func load(vc: LunchListTableViewController){
        
        RemoteRepository.shared.getRestaurants { restaurants, error in
            self.error = error
            
            self.original_restaurants = restaurants
            
            DispatchQueue.main.async {
                vc.update()
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
    
    ///Return a list of MapViewModelItems
    func getMapViewModel()->[MapViewViewModelItem]?{
        return original_restaurants?.map { restaurant in
            return .init(name: restaurant.name, location_long: restaurant.location.lng, location_lat: restaurant.location.lat)
        }
    }
    
}



struct LunchTableCellViewModel: Hashable {
    
    var name:String
    var category:String
    var url:String
    
}

struct LunchDetailViewViewModel{

    var name:String
    var category:String
    var location_long:Double
    var location_lat:Double
    var data:[String]

}

struct MapViewViewModelItem{

    var name:String
    var location_long:Double
    var location_lat:Double
    

}
