//
//  ImageLoaderService.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 05/08/21.
//

import UIKit

class ImageLoaderService: NSObject {
    //MARK: - Properties
    static var shared = ImageLoaderService()

    private var cache = NSCache<NSString,UIImage>()
    private lazy var networkService = NetworkService()
    private var imageListeners:[String:UIImageView] = [:]
    
    //MARK: - Public Functions
    
    func loadImageOnView(url:String, imageView:UIImageView ) {
        if let image = cache.object(forKey: url as NSString){
            imageView.image = image
        }else{            
            imageListeners[url] = imageView
            loadImageData(url: url)
        }
    }
    
    func removeObserver(image:UIImageView, for url:String){
        print("ImageLoaderService: removeObserver: \(url)")

        if imageListeners[url] == image{
            imageListeners.removeValue(forKey: url)
        }
        
    }
    

    //MARK: - Private Functions

    private func loadImageData(url:String){
        
        print("ImageLoaderService: loadImageData: \(url)")
        
        networkService.request(url: url) { data, _error in
            guard let imageData = data else{return}
            guard let image = UIImage(data: imageData) else{return}
            
            self.cache.setObject(image, forKey: url as NSString)
            
            guard let imageView =  self.imageListeners[url] else {return}
            
            DispatchQueue.main.async {
                imageView.image = image
            }
            
            self.imageListeners.removeValue(forKey: url)
        }
    }
    
}
