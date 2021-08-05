//
//  LunchDetailDataView.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 04/08/21.
//

import UIKit

class LunchDetailDataView: UITableView {

    var data:[String]?{
        didSet{
            configure()
        }
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        self.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.dataSource = self
        self.allowsSelection = false
    }
    
    private func configure(){
        self.reloadData()
        self.separatorStyle = .none

    }
}

extension LunchDetailDataView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {fatalError()}
        
        cell.textLabel?.font = UIFont.customRegular
        cell.textLabel?.numberOfLines = 0
        if let _data = data {
            cell.textLabel?.text = _data[indexPath.row]
        }else{
            cell.textLabel?.text = ""
        }

        return cell
    }
    
    
}
