//
//  AccessTokenModel.swift
//  Survey App
//
//  Created by PRAKASH on 7/24/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import Foundation


struct AccessTokenModel: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Double
    let createdAt: Double
}

extension AccessTokenModel {
    enum CodingKeys: String, CodingKey {
        case accessToken    =   "access_token"
        case tokenType      =   "token_type"
        case expiresIn      =   "expires_in"
        case createdAt      =   "created_at"
    }
}


