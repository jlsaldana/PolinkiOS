//
//  UserDS.swift
//  Polink
//
//  Created by Jose Saldana on 22/02/2020.
//  Copyright © 2020 Jose Saldana. All rights reserved.
//

import Foundation
import FirebaseFirestore

class UserDS {
    var uid: String?
    var fname: String?
    var lname: String?
    var dob: Date?
    var gender: String?
    var location: GeoPoint?
    var geoLocCountry: String?
    var geoLocCity: String?

    
    var regCompletion: [Bool] = Array(repeating: false, count: 3)
    var polinkIdeology: [String : Double] = [:]
    
    // Singleton to store all information
    static let user = UserDS()
    
//    MARK: Setters
    func writeFLD(_ firstname: String, lastname: String, dateOfBirth: Date){
        fname = firstname
        lname = lastname
        dob = dateOfBirth
        print("Primary information has been recorded")
    }
    func writeGender(_ gender: String){
        self.gender = gender
        print("Gender has been recorded")
    }
    func writegeoLoc(_ geoLocCountry: String, geoLocCity: String){
        self.geoLocCountry = geoLocCountry
        self.geoLocCity = geoLocCity
        print("Geolocation has been recorded")
    }
    func writeLocation(_ location: GeoPoint){
        self.location = location
        print("Latitude and Longitude were recorded")
    }
    func completePage(index: Int) {
        regCompletion[index] = true
    }
    func incompletePage(index: Int) {
        regCompletion[index] = false
    }

}
