import Foundation
import UIKit

struct MainWeatherModel: Codable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list:[List]?
    var city: CityModel?
}

struct List: Codable {
    var dt: Int?
    var main: MainModel?
    var weather: [WeatherM]?
    var dt_txt: String?
}

struct MainModel: Codable {
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
}

struct WeatherM: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
    


struct CityModel: Codable {
    var id: Int?
    var name:String?
}
