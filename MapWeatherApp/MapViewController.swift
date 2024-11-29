//
//  MapViewController.swift
//  MapWeatherApp
//
//  Created by Umidjon Fayzimatov on 08/08/24.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    //elon qilib olamiz, bu MAPni chizib beradigan view
    private var mapView: GMSMapView!
    
    //belgilagan joyimizga marker qoyib beradi
    private var currentMarker: GMSMarker!
    
    //qoyilgan markerlarni sanab ketsin
    private var counter = 1
    
    //lokatsiya bilan ishlaganimizda
    var locationManager: CLLocationManager!
    
    var curWeatherView : CurrentWheatherView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        
        self.curWeatherView = CurrentWheatherView(frame: CGRect(x: 30, y: 0, width: windowWidth - 60, height: 200))
        
        //locationMenejer yaratdik
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.initViews()
        //ruhsat sorayabmiz
        self.requestForLocation()
    }

    
    //ruhsat sorash uchun func
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
    
    
    func initViews() {
        
        self.mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight))
        //user korib turgan joy .camera
        
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
        
        
        self.mapView.mapType = .hybrid
    }

    
    //pozitsiya beramiz, osha berilgan pozitsiyaga marker qoyib bersin
    private func addMarkerTo(coordinate: CLLocationCoordinate2D) {
        
        let marker = GMSMarker(position: coordinate)
        marker.title = "Me"
        marker.snippet = "This is my location"
        
        
        //2-usul, viewga chiqazish
        let pinview = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pinview.layer.cornerRadius = 22
        pinview.backgroundColor = .cyan
        
        let pinimage = UILabel(frame: CGRect(x: 4, y: 4, width: 36, height: 36))
        pinimage.text = "\(self.counter)"
        pinimage.textAlignment = .center
        pinimage.font = .boldSystemFont(ofSize: 24)
        pinimage.textColor = .white
        pinview.addSubview(pinimage)
        
        
        //view bervorish
        marker.iconView = pinview
        marker.position = coordinate
        marker.map = self.mapView
        
        self.counter += 1
    }
    
    func showWeatherDialog() {
        self.curWeatherView.center.y = self.mapView.center.y
        //current marker qayerda turgan bolsa osha pozitsiyani lokcationini olib shu boyicha ob havo danniysini olib kelib beradi
        self.curWeatherView.updateData(with: self.currentMarker.position)
        if nil == self.curWeatherView.superview {
            self.view.addSubview(self.curWeatherView)
        }
        
    }
    
}

  
extension MapViewController:  GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        print("Tapped", coordinate)
//        print("Zoom", self.mapView.camera.zoom)
//        let zoom = self.mapView.camera.zoom
//        //har bosilganda animatsiya bolib 1 ta zoom yaqinlashadi
//        self.mapView.animate(toZoom: (zoom + 1))
        
        
//        //MARK: Bitta marker qoyish uchun shu ish/di
//        //currentMarkerizmini kooordinatasiga bosilgan joyni kordinatasi berib qoydik
//        self.currentMarker.position = coordinate
//        //yangi kordinatani mapda korsatish uchun shunday yoziladi
//        self.currentMarker.map = self.mapView
        
        
//        self.addMarkerTo(coordinate: coordinate)
        
        
        self.currentMarker.position = coordinate
        self.currentMarker.map = self.mapView
        self.mapView.animate(toLocation: self.currentMarker.position)
        self.showWeatherDialog()
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//        let zoom = self.mapView.camera.zoom
//        //har bosilganda animatsiya bolib 1 ta zoom uzoqlashadi
//        self.mapView.animate(toZoom: (zoom + 1))

        
        self.locationManager.startUpdatingLocation()
        return true
    }
    
    //marker bosilish
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.title, marker.snippet)
        return true
    }
    
    
    
}



extension  MapViewController: CLLocationManagerDelegate {
    
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
            self.curWeatherView.removeFromSuperview()
        }
    }
    
    
  
    
}






class CurrentWheatherView : UIView {
    
    var labelTemp = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.labelTemp = UILabel(frame: CGRect(x: 16, y: 16, width: self.frame.width * 0.3, height: self.frame.width * 0.3))
        self.labelTemp.textColor = .black
        self.labelTemp.font = .boldSystemFont(ofSize: 28)
        self.labelTemp.textAlignment = .center
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.35
        
        self.addSubview(self.labelTemp)
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    
    func updateData(with location: CLLocationCoordinate2D) {
        self.getCurrentWeather(location: location)
    }
    
    
    //API dan danniy olib kelib urlga yozadi
    func getCurrentWeather(location: CLLocationCoordinate2D) {
        
       
        APIClient.getCurrentWeather(location: location) { response in
            
            if let data = response {
                print(data)
                self.labelTemp.text = "\(Int((data.main?.temp ?? 0).rounded())) ˚C"
                
                
//                if let weather = data.weather, weather.count > 0, let icon = weather[0].icon {
//                    self.imageView.pin_setImage(from: URL(string: "http://openweathermap.org/img/wn/\(icon).png"))
//                    
//                    //hozir bu holatida ishlamaydi sababi internetga chiqilganda security tarafdan ruhsat berilmagan uni info plistdan togrilaymiz, kod yozamiz
//                    
//                }
                
            }
            
        }
    }
    
    
}






