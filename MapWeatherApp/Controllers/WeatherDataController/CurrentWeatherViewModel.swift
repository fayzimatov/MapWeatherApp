//
//  CurrentWeatherViewModel.swift
//  MapWeatherApp
//
//  Created by Umidjon Fayzimatov on 11/08/24.
//

import Foundation
import CoreLocation

class CurrentWeatherViewModel {
    
    
    
    //protocolni ishlatvoradigan
    var delegate: CurrentWeatherViewDelegate?
    
    
    var rowData = [(String, String)]()
    
    
    var mainData : (String, String, String)?
    
    private var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.284177, longitude: 69.224373)
    
    
    var current : CLLocationCoordinate2D {
        return self.currentLocation
    }
    
    //API dan danniy olib kelib urlga yozadigan metod
    func getCurrentWeather() {
        self.delegate?.showLoader()
        APIClient.getCurrentWeather(location: self.currentLocation) { response in
            self.delegate?.hideLoader()
            //responce kelsa va mos bolsa weather modelni chaqiryabdi
            if let data = response {
                print(data)
                self.initData(data: data)
                
            }
            
        }
    }
    
    private func initData(data: WeatherModel) {
        
        self.rowData.removeAll()
        if let value = data.main?.temp_max {
            self.rowData.append(("Max temp.", "\(value.rounded()) ˚C"))
        }
        
        if let value = data.main?.temp_min {
            self.rowData.append(("Min temp.", "\(value.rounded()) ˚C"))
        }
        
        if let value = data.main?.humidity {
            self.rowData.append(("Humidity", "\(value)"))
        }
        
        if let value = data.main?.pressure {
            self.rowData.append(("Pressure", "\(value) P"))
        }
        
        if let value = data.visibility {
            self.rowData.append(("Visibility", "\(value)"))
        }
        
    
        if let value = data.wind?.speed {
            self.rowData.append(("Wind speed", "\(value.rounded()) m/s"))
        }
        
        
        
        let  temp = "\(Int((data.main?.temp ?? 0).rounded())) ˚C"
        var image : String = "https://freepngimg.com/thumb/categories/2254.png"
        if let weather = data.weather, weather.count > 0, let icon = weather[0].icon {
            image = "http://openweathermap.org/img/wn/\(icon).png"
        }
        
        
        var fullName = ""
        if let value = data.sys?.country {
            fullName = "\(value), "
        }
        
        if let value = data.name {
            fullName += value
        }
        
        self.mainData = (temp, image, fullName)
        
        
        //data tayyor deb aytib yuborish kerak
        self.delegate?.onFetchData()
        
        
        
    }
    
    
    //bunga location keladi va uni currentlocationga yozadi
    func setLocation(_ location: CLLocationCoordinate2D) {
        self.currentLocation = location
        self.getCurrentWeather()
    }
}
