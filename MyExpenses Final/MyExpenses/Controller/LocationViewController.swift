//
//  LocationViewController.swift
//  MyExpenses
//
//  Created by Temesgen Daniel on 06/12/2020.
//  Copyright © 2020 kodechamp. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var myShopName: UITextField!
    @IBOutlet weak var myShopLatitude: UITextField!
    @IBOutlet weak var myShopLongitude: UITextField!
    
    
    @IBOutlet weak var shopMap: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
        
        //print("Latitude \(shop_latitude) and Longitude \(shop_longitude)")
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(mapPress(gestureRecognizer:)))
        shopMap.addGestureRecognizer(gesture)
        
        checkLocationServices()
        
    }
    
    func saveCategories(){
        
        do{
            try context.save()
        }catch {
            print("Error saving category with \(error)")
        }
    }
    
    
    @objc func mapPress(gestureRecognizer: UIGestureRecognizer) {
        
        shopMap.removeAnnotation(annotation)
        let touchpointtemp = gestureRecognizer.location(in: self.shopMap)
        let coordinate = self.shopMap.convert(touchpointtemp, toCoordinateFrom: self.shopMap)
        
        annotation.coordinate = coordinate
        annotation.title = myShopName.text
        
        shopMap.addAnnotation(annotation)
        
        myShopLatitude.text = "\(coordinate.latitude)"
        myShopLongitude.text = "\(coordinate.longitude)"
        
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNewShop(_ sender: UIButton) {
        //make sure all input are given
        if(myShopName.text!.isEmpty || myShopLatitude.text!.isEmpty || myShopLongitude.text!.isEmpty ){
            
            let alert = UIAlertController(title: "ooops!", message: "Incomplete input", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        }else{
            print("Sending Shop Details \(myShopName.text!) and \(myShopLatitude.text!) and \(myShopLongitude.text!)")
            
            let newCategory = Category(context: self.context)
            newCategory.name = myShopName.text!
            newCategory.latitude = (Double(myShopLatitude.text!))!
            newCategory.longitude = (Double(myShopLongitude.text!))!
            newCategory.profile = UIImage (named: "shop.png")?.pngData()
            
            self.categories.append(newCategory)
            self.saveCategories()
            dismiss(animated: true, completion: nil)
            
        }
        //NotificationCenter.default.post(name: Notification.Name("text"), object: myShopName.text!)
    }
    
    //Use this function alongside Get coordinate button to get Shop Latitude and longitude
    @IBAction func getCoordinate(_ sender: UIButton) {
        // set myShopLatitude
        // set myShopLongitude
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            shopMap.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            shopMap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            shopMap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            fatalError()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        shopMap.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
