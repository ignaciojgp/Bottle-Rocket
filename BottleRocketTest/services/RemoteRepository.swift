//
//  RemoteRepository.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit


class RemoteRepository: NSObject {
    
    static var shared = RemoteRepository()
    
    
    struct RemoteError:Error{
        var title:String
        var message:String
    }
    
    private var cache = NSCache<NSString,UIImage>()
    
    private lazy var decoder = JSONDecoder()
    private lazy var networkService = NetworkService()
    
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
    
    func getImage(url:String, handler: @escaping (UIImage?, RemoteError?)->Void){
        
        
        if let image = cache.object(forKey: url as NSString){
            handler(image, nil)
        }else{
            networkService.request(url: url) { data, _error in
                
                guard let imageData = data else{
                    handler(nil, RemoteError.init(title:"Something went wrong", message: "unable to get image"))
                    return
                }
                
                guard let image = UIImage(data: imageData) else{
                    handler(nil, RemoteError.init(title: "Something went wrong", message: "unable to convert the image"))
                    return
                }
                
                self.cache.setObject(image, forKey: url as NSString)
                
                handler(image, nil)
                
                
            }
            
        }
        
        
    }
    
}
