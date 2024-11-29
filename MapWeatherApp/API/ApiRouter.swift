//
//  ApiRouter.swift
//  SwiftAcademy2Davomi
//
//  Created by Umidjon Fayzimatov on 26/07/24.
//

import UIKit
import Alamofire
import CoreLocation

//ApiRouter ning bajaradigan ishi requestning obyektini yaratib beradi
//URLRequestConvertible -> Alamofiredan kelgan class, url request qilib beradigan protocol
enum ApiRouter: URLRequestConvertible {
    
    case currentWeather(location: CLLocationCoordinate2D)
//    case dailyWeather
//    case hourlyWeather
    
    //metod bilan url yani 1  bn 2 chisi obyazatelniy qolganlari optional
    //MARK: 1 chisi
    //url
    var path: String {
        switch self {
            //request beriladi yani boshlanishi
        case .currentWeather: return URLS.getCurrent
        }
    }
    
    
    //MARK: 2 chisi
    //api type,metod
    var method: HTTPMethod {
        switch self {
        case .currentWeather: return .get
        }
    }
    
    
    
    //MARK: 3 chisi
    //query
    //https://api.openweathermap.org/data/2.5/weather?lat=41.2840274475893&lon=69.22443954548164&appid=988ca685747d38c14d9770770f978f5d&units=metric
    //query larni ozimiz bittalab yozib chiqdik aslida unday qilmasdan turib pathga tepadegi toliq urlni bervorsak ham boladi ozi querylarini bolib chiqadi
    var query: Parameters? {
        switch self {
        case .currentWeather(let location):
            return ["lat" : location.latitude,
                    "lon" : location.longitude,
                    "appid" : "988ca685747d38c14d9770770f978f5d",
                    "units" : "metric"]
        }
    }
    
    
    //MARK: 4 chisi
    //body
    var parameters: Parameters? {
        return nil
    }
    
    
    func asURLRequest() throws -> URLRequest {
        //url request yaratayotgan paytda pathni hosil qildi
        var urlRequest = URLRequest(url: try path.asURL())
        print("Sending url: \(try path.asURL())")
        
        //requestga metod berayabdi
        urlRequest.httpMethod = method.rawValue
        
        //querylarimiz bormi deyabdi bor bolsa oshani requestimziga qoshib berayabdi
        if query != nil {
            urlRequest = try
            URLEncoding.queryString
                .encode(urlRequest, with: query)
            
            print("Sending queries: \(String(describing: query))")
        }
        
        //header qoshayabdi keyin request hosil qilayabdi
        //HEADERS
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try
                JSONSerialization .data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
        
}
//1 - qism boldi desak ham boladi bu yerda request bilan ishladik, endi Responseni headeri bilan ishlaymiz va yangi file ochvolamiz APIClient deb

//API request va responsedan iborat, request 5 tadan tashkil topgan: 1-manzili(url), 2-request turi(get,pet...), 3-query(url qoshimcha ketadigan shartlar),4-parametrlar(body qismi),5-header
