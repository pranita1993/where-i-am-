//
//  ViewController.swift
//  where i am 16
//
//  Created by Student P_04 on 16/12/19.
//  Copyright © 2019 Felix ITs. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    var locationManger = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var mapType: UISegmentedControl!
 
    
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        let index = mapType.selectedSegmentIndex
        switch index {
        case 0:
            mapview.mapType = .standard
        case 1:
            mapview.mapType = .hybrid
        case 2:
            mapview.mapType = .satellite
            default:
            mapview.mapType = .standard
        }
        
        
        
        
    }
    
    @IBOutlet weak var mapview: MKMapView!
    @IBAction func detectLocation(_ sender: UIButton) {
        locationManger = CLLocationManager()
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    let currentLocation = locations.last!
        
        print("latitude = \(currentLocation.coordinate.latitude)and longitude = \(currentLocation.coordinate.longitude)")
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        mapview.setRegion(region, animated: true)
        //pin mark on map
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation.coordinate
        //mapview.addAnnotation(annotation)
        //extra information about landmark
        
        let geo = CLGeocoder()
        geo.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            let placemark = placemarks?.first!
            let title = placemark?.name
            annotation.title = title
           self.mapview.addAnnotation(annotation)

        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

