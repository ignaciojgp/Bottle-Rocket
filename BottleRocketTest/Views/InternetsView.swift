//
//  InternetsView.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 05/08/21.
//

import UIKit
import WebKit

class InternetsView: UIView {

    private let navBar: UINavigationBar = {
        let view = UINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = UIColor.white
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "green")
        
        view.compactAppearance = appearance
        view.standardAppearance = appearance
        view.scrollEdgeAppearance = appearance
        
        
        return view
    }()
    
    private let navItem:UINavigationItem = {
        let view = UINavigationItem(title: "")
        return view
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

}

extension InternetsView:UINavigationBarDelegate{
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
