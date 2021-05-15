//
//  LoginResponse.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 15.05.2021..
//

import Foundation

struct LoginResponse: Codable {
    
    let token: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case token
        case userId = "user_id"
    }
    
}
