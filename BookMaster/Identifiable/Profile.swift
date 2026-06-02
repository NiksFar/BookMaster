//
//  Profile.swift
//  BookMaster
//
//  Created by Nikita on 29.05.2026.
//

import Foundation

class Profile: Identifiable {
    let id: String
    let name: String
    let email: String
    let phone: Int
    
  //  var bookings: [Booking]
    
    init(id: String, name: String, email: String, phone: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
}

extension Profile {
    convenience init?(representation: [String: Any]) {
        guard let id = representation["id"] as? String,
              let name = representation["name"] as? String,
              let email = representation["email"] as? String,
              let phone = representation["phone"] as? Int else {
            return nil
        }
        self.init(id: id, name: name, email: email, phone: phone)
    }
}

extension Profile {
    var representation: [String: Any] {
        var representation: [String: Any] = [:]
        representation["id"] = id
        representation["name"] = name
        representation["email"] = email
        representation["phone"] = phone
        
        return representation
    }
}
