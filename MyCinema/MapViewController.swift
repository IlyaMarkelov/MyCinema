//
//  MapViewController.swift
//  MyCinema
//
//  Created by Илья Маркелов on 25/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var cinema: Cinema!
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlacemark()

    }
    
    @IBAction func closeVC() {
        dismiss(animated: true)
    }
    
    private func setupPlacemark() {
        
        guard let location = cinema.detailLocation else {return}
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else {return}
            
            let placemark = placemarks.first
            let annotation = MKPointAnnotation()
            annotation.title = self.cinema.name
            annotation.subtitle = self.cinema.location
            
            guard let placemarkLocation = placemark?.location else {return}
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
}
