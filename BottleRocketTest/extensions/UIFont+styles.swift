//
//  UIFont+styles.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 04/08/21.
//

import UIKit

extension UIFont{
    
    static let customTitle:UIFont = {
        guard let font =  UIFont(name: "Avenir Next Demi Bold", size: 16) else{
            return UIFont.systemFont(ofSize: 16)
        }
        
        return font
    }()
    
    static let customSubtitle:UIFont = {
        guard let font =  UIFont(name: "Avenir Next Regular", size: 12) else{
            return UIFont.systemFont(ofSize: 16)
        }
        
        return font
    }()
    
    static let customRegular:UIFont = {
        guard let font =  UIFont(name: "Avenir Next Regular", size: 16) else{
            return UIFont.systemFont(ofSize: 16)
        }
        
        return font
    }()
    
    
}
