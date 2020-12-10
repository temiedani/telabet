//
//  ViewController.swift
//  MapKit2
//
//  Created by Rabeb Mizouni on 23/11/2020.
//  Copyright © 2020 Rabeb Mizouni. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var myMap: MKMapView!
    let locationManager = CLLocationManager()
    
    var sizeofRegion : Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkLocationService()
    }

    func setUpLocationManager() {
        
        locationManager.delegate  = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationService(){
        
        if CLLocationManager.locationServicesEnabled()
        {
            
            setUpLocationManager()
            checkAuthorization()
        }
        
        else {
            print ("not enabled")
        }
    }
    
    func spanOnUserLocation(){
        
        if let location = locationManager.location?.coordinate {
            
            let region = MKCoordinateRegion.init(center: location , latitudinalMeters: sizeofRegion, longitudinalMeters: sizeofRegion )
            myMap.setRegion(region, animated: true)
        }
    }
    
    func checkAuthorization(){
        switch CLLocationManager.authorizationStatus()
        {
        case .authorizedWhenInUse : //you have already allowed the applicstion to use the service while in use
            myMap.showsUserLocation = true
            spanOnUserLocation()
            locationManager.startUpdatingLocation()
            
            break
        case .notDetermined: // first time
            
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted: // there are some restrictions omn the use of the service like parental control
            break
        case .authorizedAlways: // even when the application  in the background ....
            break;
        case .denied : // show alert instrcuting them how to turn on the permissions
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: sizeofRegion, longitudinalMeters: sizeofRegion)
        myMap.setRegion(region, animated: true)
        
        
    }
    
}

