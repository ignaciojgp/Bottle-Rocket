//
//  MapView.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 05/08/21.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIView {
    
    //MARK: - Properties
    
    var viewmodel:[MapViewViewModelItem]?{
        didSet{
            configure()
        }
    }
    
     private let mapView:MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topBar:UINavigationBar = {
        let view = UINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(named: "green")
        
        
        return view
    }()
    


    //MARK: - init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    //MARK: - Private methods
    
    private func setup(){
        addSubview(mapView)
        addSubview(topBar)
        
        let guides = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: guides.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: guides.trailingAnchor),

            mapView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: guides.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),

        ])
    }
    
    private func configure(){
        
        mapView.removeAnnotations(mapView.annotations)
        
        guard let _viewmodel = viewmodel else {return}
        
        var minLat:Double? = nil
        var maxLat:Double? = nil
        var minLng:Double? = nil
        var maxLng:Double? = nil
        
        for i in _viewmodel{
            
            minLat = minLat == nil ? i.location_lat : min(minLat!, i.location_lat)
            maxLat = maxLat == nil ? i.location_lat : max(maxLat!, i.location_lat)

            minLng = minLng == nil ? i.location_long : min(minLng!, i.location_long)
            maxLng = maxLng == nil ? i.location_long : max(maxLng!, i.location_long)

            let anotation = MKPointAnnotation()
            anotation.title = i.name
            anotation.coordinate = CLLocationCoordinate2D(latitude: i.location_lat, longitude: i.location_long)
            mapView.addAnnotation(anotation)
            
        }
        
        guard let _minLat = minLat, let _minLng = minLng, let _maxLat = maxLat, let _maxLng = maxLng else{return}
        
        
        let lat = (_maxLat + _minLat) / 2
        let lng = (_maxLng + _minLng) / 2
        
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        let leftTopCorner = CLLocation(latitude: _minLat, longitude: _minLng)
        let rightBottomCorner = CLLocation(latitude: _maxLat, longitude: _maxLng)
        
        let distance = leftTopCorner.distance(from: rightBottomCorner)
        
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: distance*3)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        mapView.setCenter(center, animated: true)
    }

}
