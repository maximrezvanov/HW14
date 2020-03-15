//
//  Persistance.swift
//  HW14_2
//
//  Created by MaximRezvanov on 3/13/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//


import Foundation

class Persistance {

    static let shared = Persistance()

    private let kFirstNameKey = "Persistance.firstName"
    private let kSecondNameKey = "Persistance.secondName"
    
    var firstName: String? {

        set {
            UserDefaults.standard.set(newValue, forKey: "kFirstNameKey")
        }
        get {
            UserDefaults.standard.string(forKey: "kFirstNameKey")

        }
    }

    var secondName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "kSecondNameKey")
        }
        get {
            return UserDefaults.standard.string(forKey: "kSecondNameKey")
        }

    }




}
