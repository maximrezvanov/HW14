

import Foundation
import  UIKit

struct DataWeather: Codable {
    var id: Int?
    var name: String?
    var weather: [Weather]? = []
    var main: MainData = MainData()
   
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}


struct MainData: Codable {
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
}
