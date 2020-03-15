//
//  DataStorage.swift
//  HW14_2
//
//  Created by MaximRezvanov on 3/14/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import Foundation

class DataStorage {
    static let shared = DataStorage()
    
    private let kDtLabelKey = "DataStorage.kDtLabelKey"
    private let kDescriptionKey = "DataStorage.kDescriptionKey"
    private let kCityNameLabelKey = "DataStorage.kCityNameLabelKey"
    private let kTemperatureLabelKey = "DataStorage.kTemperatureLabelKey"
    private let kTempMinLabelKey = "DataStorage.kTempMinLabelKey"
    private let kTempMaxLabelKey = "DataStorage.kTempMaxLabelKey"

    
    var dtLabel: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: "kDtLabelKey")
        }
        get {
            UserDefaults.standard.string(forKey: "kDtLabelKey")        }
    }
    var description: String?{
        set{
            UserDefaults.standard.set(newValue, forKey: "kDescriptionKey")
        }
        get {
            UserDefaults.standard.string(forKey: "kDescriptionKey")
        }
    }
    var cityName: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: "kCityNameLabelKey")
        }
        get {
            UserDefaults.standard.string(forKey: "kCityNameLabelKey")
        }
    }
    var temperature: Double? {
        set{
            UserDefaults.standard.set(newValue, forKey: "kTemperatureLabelKey")
        }
        get {
            UserDefaults.standard.double(forKey: "kTemperatureLabelKey")
        }
    }
    var tempMin: Double? {
        set{
            UserDefaults.standard.set(newValue, forKey: "kTempMinLabelKey")
        }
        get {
            UserDefaults.standard.double(forKey: "kTempMinLabelKey")
        }
    }
    
    var tempMax: Double? {
        set{
            UserDefaults.standard.set(newValue, forKey: "kTempMaxLabelKey")
        }
        get {
            UserDefaults.standard.double(forKey: "kTempMaxLabelKey")
        }
    }
    
    
}
