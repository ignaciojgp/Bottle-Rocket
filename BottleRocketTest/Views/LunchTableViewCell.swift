//
//  LunchTableViewCell.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit



class LunchTableViewCell: UITableViewCell {

    var viewModel: LunchTableCellViewModel?{
        didSet{
            configure()
        }
    }
    
    //MARK: - Subviews
    private let descriptionImage:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let screen:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cellGradientBackground")
        return imageView
    }()
    
    private let titleLbl:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    private let subTitleLbl:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir Next Regular", size: 12)
        label.textColor = UIColor.white
        return label
    }()

    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    //MARK: - Setup
    
    private func setup(){
        
        contentView.addSubview(descriptionImage)
        contentView.addSubview(screen)
        contentView.addSubview(titleLbl)
        contentView.addSubview(subTitleLbl)
        
        titleLbl.text = "title"
        subTitleLbl.text = "title"

        NSLayoutConstraint.activate([
            
            descriptionImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            subTitleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            subTitleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            titleLbl.bottomAnchor.constraint(equalTo: subTitleLbl.topAnchor, constant: -6),

        ])
        
    }
    
    
    private func configure(){
        titleLbl.text = viewModel?.title
        subTitleLbl.text = viewModel?.subtitle
        descriptionImage.image = viewModel?.image
    }
}
