//
//  APIClient.swift
//  SwiftAcademy2Davomi
//
//  Created by Umidjon Fayzimatov on 26/07/24.
//

import Foundation
import Alamofire
import CoreLocation

//sessiya yaratib, bunga requestlarni yuborib qaytaradigan func yaratadi
// Класс для обработки API-запросов с использованием Alamofire
class APIClient {
    
    /// Выполняет API-запрос и декодирует ответ.
    ///
    /// - Параметры:
    ///   - route: Маршрут API для выполнения запроса.
    ///   - throwLogin: Флаг для указания необходимости обработки ошибок входа.
    ///   - decoder: JSONDecoder для декодирования ответа.
    ///   - completion: Замыкание для обработки декодированного ответа.
    ///
    /// - Возвращает: Экземпляр DataRequest.
    @discardableResult
    static func performRequestScale<T: Codable>(
        route: ApiRouter,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (T?) -> Void
    ) -> DataRequest {
        
        return AF.request(route).responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let resData):
                completion(resData)
                print(resData)
            case .failure(let error):
                // Обработка ошибки
                print("-- НЕОБРАБОТАННЫЙ КОД ОШИБКИ \(error.responseCode ?? 0), \(error.errorDescription ?? "")")
                
                // Вызов замыкания с nil при ошибке
                completion(nil)
            }
        }
    }
    
    
    static func getCurrentWeather(location: CLLocationCoordinate2D, completion: @escaping (WeatherModel?) -> Void) {
        performRequestScale(route: .currentWeather(location: location), completion: completion)
    }
}


