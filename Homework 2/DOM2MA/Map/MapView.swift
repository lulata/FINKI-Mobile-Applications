//
//  MapView.swift
//  DOM2MA
//
//  Created by David Atanasoski on 17.9.23.
//

import Foundation

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapView:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        map.showsUserLocation = true
        
        let locations = [
                    ["name": "vfv pharmacy", "longitude": 21.310788, "latitude": 42.041729],
                    ["name": "Jovana Farm 2", "longitude": 21.397460, "latitude": 41.998110],
                    ["name": "Зегин - Монопол", "longitude": 21.431600, "latitude": 41.997970],
                    ["name": "Apteka 24", "longitude": 21.431710, "latitude": 41.995550],
                    ["name": "Apteka Farmacija", "longitude": 21.430680, "latitude": 41.996560],
                    ["name": "Apteka 2000", "longitude": 21.430430, "latitude": 41.996920],
                    ["name": "Apteka Galenika", "longitude": 21.433920, "latitude": 41.996700],
                    ["name": "Apteka Zdravlje", "longitude": 21.431640, "latitude": 41.998220],
                    ["name": "Apteka Leko", "longitude": 21.431620, "latitude": 41.999290],
                    ["name": "Apteka Vital", "longitude": 21.433070, "latitude": 42.000120],
                    ["name": "Apteka Bio", "longitude": 21.433040, "latitude": 42.001740],
                    ["name": "Apteka Homeo", "longitude": 21.433170, "latitude": 42.002810]
                ]
                
                for location in locations {
                    if let name = location["name"] as? String,
                       let longitude = location["longitude"] as? CLLocationDegrees,
                       let latitude = location["latitude"] as? CLLocationDegrees {
                        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        addPlaceToMap(coordinate: coordinate, title: name, subtitle: "")
                    }
                }
        
    }
    
    var annotations: [MKPointAnnotation] = []
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    func addPlaceToMap(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        
        map.addAnnotation(annotation)
        
        // Add the annotation to your list for reference
        annotations.append(annotation)
    }
    
}
