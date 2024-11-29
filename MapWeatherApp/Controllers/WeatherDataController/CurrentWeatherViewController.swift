//
//  CurrentWeatherViewController.swift
//  MapWeatherApp
//
//  Created by Umidjon Fayzimatov on 11/08/24.
//

import UIKit
import GoogleMaps
import CoreLocation

class CurrentWeatherViewController: UIViewController {

    //obyekt yaratildi chaqirilganida hotiradan joy egallaydi
    private var tableView: UITableView!
    
    
    internal var viewModel = CurrentWeatherViewModel()
    
    
    private var indicator: UIActivityIndicatorView!
    
    private var mapView: GMSMapView!
    
    private var currentMarker: GMSMarker!
    
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.viewModel.delegate = self
        self.initTable()
        self.requestForLocation()
        self.viewModel.getCurrentWeather()

    }
    
    
    private func initTable() {
        
        let mapHeight: CGFloat = windowHeight * 0.3
        self.mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: windowWidth, height: mapHeight))
        
        self.mapView.settings.myLocationButton = true
        self.mapView.delegate = self
        self.view.addSubview(mapView)
        
        
        
        //MARK: Bitta marker qoyish uchun shu ish/di
        self.currentMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0))
        //1-usul faqat shu iconni ozini chiqazish
//        self.currentMarker.icon = UIImage(named: "marker")
        self.currentMarker.title = "Me"
        self.currentMarker.snippet = "This is my location"


        //2-usul, viewga chiqazish
        let pinview = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pinview.layer.cornerRadius = 22
        pinview.backgroundColor = .cyan

        let pinimage = UIImageView(frame: CGRect(x: 4, y: 4, width: 36, height: 36))
        pinimage.layer.cornerRadius = 18
        pinimage.clipsToBounds = true
        pinimage.layer.masksToBounds = true
        pinimage.image = UIImage(named: "marker")
        pinimage.contentMode = .scaleToFill
        pinview.addSubview(pinimage)

        //view bervorish
        self.currentMarker.iconView = pinview
        
        
        
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: self.mapView.frame.maxY, width: windowWidth, height: windowHeight - mapHeight))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.separatorColor = .none
        self.view.addSubview(self.tableView)
        
        if #available(iOS 13.0, *) {
            self.indicator = UIActivityIndicatorView(style: .medium)
        } else {
            self.indicator = UIActivityIndicatorView(style: .gray)
        }
        self.view.addSubview(self.indicator)
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        
    }
 
    
    private func requestForLocation() {
        
        //statuslari
        switch (CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            
            
            //ruhsat ololsak keyin startupdating qildik
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            //setting
            break
        @unknown default:
            print("error")
        }
    }
    
   
}


extension CurrentWeatherViewController: CurrentWeatherViewDelegate {
    func showLoader() {
        self.indicator.startAnimating()
    }
    
    func hideLoader() {
        self.indicator.stopAnimating()
    }
    
    func onFetchData() {
        self.tableView.reloadData()
    }
    
    
}



extension CurrentWeatherViewController:  GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        self.currentMarker.position = coordinate
        self.currentMarker.map = self.mapView
        self.mapView.animate(toLocation: self.currentMarker.position)
        //kelgan locationni berdik
        self.viewModel.setLocation(coordinate)
        
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
 
//        self.locationManager.startUpdatingLocation()
        
        self.currentMarker.position = self.viewModel.current
        self.currentMarker.map = self.mapView
        self.mapView.animate(toLocation: self.currentMarker.position)
        self.viewModel.getCurrentWeather()
        
        
        return true
    }
    
    //marker bosilish
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return true
    }
    
    
    
}



extension  CurrentWeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
//      self.requestForLocation()
    }
      
    //app ishlab turgan paytda settingdan kirib ozgartirilsa shu ishga tushadi
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .denied || status == .restricted {
            self.requestForLocation()
        }
    }
    
    
    //app ishlab turgan paytda settingsdan kirib ozgartirilganda bu metod chaqiriladi
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        if locations.count > 0, let coordinate = locations.first?.coordinate {
            self.currentMarker.position = coordinate
            self.currentMarker.map = self.mapView
            self.mapView.animate(toLocation: self.currentMarker.position)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    
  
    
}



