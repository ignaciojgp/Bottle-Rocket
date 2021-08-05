//
//  LunchDetailView.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 04/08/21.
//

import UIKit
import MapKit

class LunchDetailView: UIView {
    //MARK: - Properties
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "green_dark")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLbl: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.white
        view.font = UIFont.customTitle
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let categoryLbl: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.white
        view.font = UIFont.customSubtitle
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dataView: LunchDetailDataView = {
        let view = LunchDetailDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var viewmodel: LunchDetailViewViewModel?{
        didSet{
            configure()
        }
    }
    
    //MARK: - Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    
    //MARK: - Private methods
    
    private func setupLayout(){
        addSubview(titleView)
        addSubview(mapView)
        addSubview(dataView)
        titleView.addSubview(nameLbl)
        titleView.addSubview(categoryLbl)
        
        let guides = safeAreaLayoutGuide
 
        NSLayoutConstraint.activate([
            
            mapView.topAnchor.constraint(equalTo: guides.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 180),
            
            titleView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            titleView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLbl.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 12),
            nameLbl.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: 12),
            nameLbl.bottomAnchor.constraint(equalTo: titleView.centerYAnchor, constant: -3),
            
            categoryLbl.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 12),
            categoryLbl.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: 12),
            categoryLbl.topAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 3),
            
            dataView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            dataView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            dataView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            dataView.bottomAnchor.constraint(equalTo: guides.bottomAnchor)
            
        ])
        
    }
    
    private func configure(){
        
        guard let _viewmodel = viewmodel else {return}
        
        //configure text
        self.nameLbl.text = _viewmodel.name
        self.categoryLbl.text = _viewmodel.category
        //configure data
        dataView.data = _viewmodel.data
        //configure map view
        configureMap(long: _viewmodel.location_long, lat: _viewmodel.location_lat)

    }
    
    private func configureMap(long:Double, lat:Double){
        let anotation = MKPointAnnotation()
        anotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.addAnnotation(anotation)
        
        let region = MKCoordinateRegion(
            center: anotation.coordinate,
            latitudinalMeters: 0,
            longitudinalMeters: 0)
        
        mapView.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region),
            animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 8000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
    }
}
