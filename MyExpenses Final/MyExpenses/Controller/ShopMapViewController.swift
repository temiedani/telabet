//
//  ShopMapViewController.swift
//  Expenses App with Core Data
//
//  Created by Temesgen Daniel on 01/12/2020.
//



import UIKit
import MapKit

class ShopMapViewController: UIViewController{
    var shop_latitude :Double! = 0.0
    var shop_longitude :Double! = 0.0
    var shop_name :String! = ""
    
    @IBOutlet weak var mapView: MKMapView!
        
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
        
        let annontation = MKPointAnnotation()
        annontation.coordinate = CLLocationCoordinate2D(latitude: shop_latitude, longitude: shop_longitude)
        annontation.title = shop_name
        annontation.subtitle = "Location of Shop"
        mapView.addAnnotation(annontation)
        
        let region = MKCoordinateRegion(center: annontation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        super.viewDidLoad()
        
    }
    
    
}
