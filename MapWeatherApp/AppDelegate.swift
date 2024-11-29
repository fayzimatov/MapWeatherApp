//
//  AppDelegate.swift
//  MapWeatherApp
//
//  Created by Umidjon Fayzimatov on 10/08/24.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window?.rootViewController = UINavigationController(rootViewController: CurrentWeatherViewController())
        
        //API keyni beramiz
        GMSServices.provideAPIKey("AIzaSyA7Apgrm53q1-RZXMirBSZs75Qgm3gERpY")
        
        return true
    }

   

}

