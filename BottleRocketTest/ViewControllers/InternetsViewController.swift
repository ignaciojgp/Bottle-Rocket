//
//  InternetsViewController.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 05/08/21.
//

import UIKit
import WebKit

class InternetsViewController: UIViewController {
    
    
    //MARK: - Properties

    private let webview: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - init

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Private methods

    private func setup(){
        view.addSubview(webview)
        
        //MARK: - Properties
        let backItem = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: self, action: #selector(tapBack))
        let forwardItem = UIBarButtonItem(image: UIImage(named: "ic_webForward"), style: .plain, target: self, action: #selector(tapForward))
        let reloadItem = UIBarButtonItem(image: UIImage(named: "ic_webRefresh"), style: .plain, target: self, action: #selector(tapReload))
            
        navigationItem.setLeftBarButtonItems([backItem, reloadItem, forwardItem], animated: true)
        webview.load(URLRequest(url: URL(string: "https://www.bottlerocketstudios.com/")!))
        
        NSLayoutConstraint.activate([
            
            webview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
    }
    

    //MARK: - Events
    @objc func tapBack(){
        webview.goBack()
    }
    
    @objc func tapReload(){
        webview.reload()
    }
    
    @objc func tapForward(){
        webview.goForward()
    }

    
}
