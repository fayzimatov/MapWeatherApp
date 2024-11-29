//
//  CurrentWeatherViewDelegate.swift
//  MapWeatherApp
//
//  Created by Umidjon Fayzimatov on 11/08/24.
//

import Foundation


protocol CurrentWeatherViewDelegate {
     
    //APIga zapros ketayotganda
    func showLoader()
    
    //APIdan zapros kelayotganda
    func hideLoader()
    
    func onFetchData()
    
}
