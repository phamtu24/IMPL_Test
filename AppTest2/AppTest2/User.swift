//
//  User.swift
//  AppTest2
//
//  Created by Pham Tu on 5/15/20.
//  Copyright © 2020 Pham Tu. All rights reserved.
//

import Foundation

struct User : Decodable {
    
    let avatar : String?
    let email : String?
    let id : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar"
        case email = "email"
        case id = "id"
        case name = "name"
    }
}
