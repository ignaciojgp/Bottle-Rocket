//
//  NetworkService.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit


class NetworkService: NSObject {
    
    enum ServiceError:Error{
        case NO_INTERNET
        case UNEXPECTED
    }
    
    
    func request(url: String, handler: @escaping (Data?, ServiceError?)->Void){
        
        guard let _url = URL(string: url) else {return}
        
        let request = URLRequest(url: _url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _error = error{
                //Errors handling
                if _error.localizedDescription.contains("The Internet connection appears to be offline"){
                    handler(nil, .NO_INTERNET)
                }else{
                    handler(nil, .UNEXPECTED)
                }
                return
            }else{
                //Successful response
                handler(data, nil)
            }
        }
        
        task.resume()
        
        
    }

}
