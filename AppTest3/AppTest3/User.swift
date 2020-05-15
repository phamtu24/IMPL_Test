//
//  User.swift
//  AppTest3
//
//  Created by Pham Tu on 5/15/20.
//  Copyright © 2020 Pham Tu. All rights reserved.
//

import Foundation

import Foundation

struct User : Decodable {
    
    let createdAt : String?
    let email : String?
    let name : String?
    let phone : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case email = "email"
        case name = "name"
        case phone = "phone"
    }
    
    init(createdAt: String?,email: String?,name: String?, phone: String?  ) {
        self.createdAt = createdAt
        self.email = email
        self.name = name
        self.phone = phone
    }
}

func handleJSON() -> [User] {
    if let path = Bundle.main.path(forResource: "data", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch let error {
            print("parse error: \(error)")
        }
    } else {
        print("Invalid filename/path.")
    }
    return [User]()
}

