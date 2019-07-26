//
//  RouterAPIs.swift
//  Survey App
//
//  Created by PRAKASH on 7/24/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import UIKit
import Alamofire

enum APIRouter: URLRequestConvertible {

    case refreshAccessToken(grant_type:String, username:String, password : String)
    case fetchSurveys
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .refreshAccessToken:
            return .post
        case .fetchSurveys:
            return .get
            
        }
        
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .refreshAccessToken:
            return "oauth/token"
        case .fetchSurveys:
            return "surveys.json"//?page=1&per_page=10"
        }
        
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .refreshAccessToken(let grant_type, let username, let password):
            return [APIHelper.APIParameterKey.grantType: grant_type, APIHelper.APIParameterKey.username: username, APIHelper.APIParameterKey.password   :   password]
        case .fetchSurveys:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try APIHelper.Server.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        let accessToken =   UIViewController().savedTokenDatas.accessToken
        if accessToken   !=  "" {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

