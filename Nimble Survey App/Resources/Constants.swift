//
//  Constants.swift
//  Survey App
//
//  Created by PRAKASH on 7/24/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import Foundation

let SavedAccessTokenDatasKey    =   "Saved AccessToken Datas Key"
struct APIHelper {
    struct Server {
        static let baseURL = "https://nimble-survey-api.herokuapp.com/"
    }
    
    struct APIParameterKey {
        static let grantType    =   "grant_type"
        static let username = "username"
        static let password = "password"
        static let requestedPageNumber = "page"
        static let limitPerPage = "per_page"
        static let access_token =   "access_token"
        
    }
    
    //These values are hardcoded now, in real case username and password will be passed form user
    struct APIParameteValues {
        static let grantType    =   "password"
        static let username = "carlos@nimbl3.com"
        static let password = "antikera"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
