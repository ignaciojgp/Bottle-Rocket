//
//  RemoteRepository.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit


class RemoteRepository: NSObject {
    
    struct RemoteError:Error{
        var title:String
        var message:String
    }
    
    //MARK: - Properties
    
    static var shared = RemoteRepository()
    private lazy var decoder = JSONDecoder()
    private lazy var networkService = NetworkService()
    
    //MARK: - Public Methods
    
    func getRestaurants(handler: @escaping ([Restaurant]?, RemoteError?)->Void) {
        
        networkService.request(url: "https://s3.amazonaws.com/br-codingexams/restaurants.json") { data, _error in
            
            if let error = _error{
                switch error {
                
                case .NO_INTERNET:
                    handler(nil, RemoteError(title: "No internet", message: "Check your connection and try again"))
                default:
                    handler(nil, RemoteError(title: "Something went wrong", message: "There was a problem to connect with the server, please try again"))
                }
                return
                
            }else{
                
                guard let _data = data else {
                    handler(nil, RemoteError(title: "Something went wrong", message: "The response from the server has no data"))
                    return
                }
                
                do{
                    let list = try self.decoder.decode(APIResponse.self, from: _data)
                    //sucessfull response
                    handler(list.restaurants, nil)
                }catch {
                    handler(nil, RemoteError(title: "Something went wrong", message: "Couldn't decode de info from server \(error.localizedDescription)"))
                }
            }
        }
        
    }
    
    
}
