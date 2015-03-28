//
//  ViewController.swift
//  Location
//
//  Created by Naoto Ida on 01/27/15
//  Copyright (c) 2015 Naoto Ida All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latitudeHolder    : UILabel!
    @IBOutlet var longitudeHolder   : UILabel!
    @IBOutlet var perimeterHolder   : UILabel!
    
    let locationManager = CLLocationManager() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate           = self
        self.locationManager.desiredAccuracy    = kCLLocationAccuracyNearestTenMeters   //Battery drain!
        self.locationManager.distanceFilter     = 1
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if error != nil {
                println("Error: " + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                var pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Error with the data.")
            }
        })
    }
    
    
    func displayLocationInfo(coords: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        var coordinates = [coords.location.coordinate.latitude, coords.location.coordinate.longitude],
            location    = Location(coordinates: coordinates)
        
        self.latitudeHolder.text    = "\(location.latitude)"
        self.longitudeHolder.text   = "\(location.longitude)"
        
        if self.inPerimeter(location) {
            self.perimeterHolder.text               = "In perimeter."
            self.perimeterHolder.backgroundColor    = UIColor.greenColor()
        } else {
            self.perimeterHolder.text               = "Out of perimeter."
            self.perimeterHolder.backgroundColor    = UIColor.redColor()
        }
    }
    
    
    func inPerimeter(loc: Location) -> Bool {
        var perimeter   = Perimeter(points: _PERIMETER),
            within      = false
        
        if
            //  Latitude
            (perimeter.pointA?.first as Double) >= loc.latitude &&
            loc.latitude >= (perimeter.pointB?.first as Double) &&
                
            //  Longitude
            (perimeter.pointC?.last as Double) >= loc.longitude &&
            loc.longitude >= (perimeter.pointD?.last as Double)
        {
            println("Location is within perimeter latitudes with \(perimeter.pointA?.first as Double) > \(loc.latitude) > \(perimeter.pointB?.first as Double)")
            println("Location is within perimeter longitudes with\(perimeter.pointC?.last as Double) > \(loc.longitude) > \(perimeter.pointD?.last as Double)")
            
            within = true
            
        } else {
            println("Not in perimeters")
        }
        return within
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
}