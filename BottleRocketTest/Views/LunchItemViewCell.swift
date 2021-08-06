//
//  LunchTableViewCell.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import UIKit



class LunchItemViewCell: UICollectionViewCell {

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
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
     
    //MARK: - Setup
    
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionImage)
        contentView.addSubview(screen)
        contentView.addSubview(titleLbl)
        contentView.addSubview(subTitleLbl)
        
        titleLbl.text = "title"
        subTitleLbl.text = "title"
        clipsToBounds = true

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
        
        guard let _viewmodel = viewModel else {return}
        
        titleLbl.text = _viewmodel.name
        subTitleLbl.text = _viewmodel.category
        
        ImageLoaderService.shared.loadImageOnView(url: _viewmodel.url, imageView: descriptionImage)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        guard let _viewModel = viewModel else {return}
        
        ImageLoaderService.shared.removeObserver(image: descriptionImage, for: _viewModel.url)
        
    }
    
    
}
