//
//  APIClient.swift
//  Survey App
//
//  Created by PRAKASH on 7/24/19.
//  Copyright © 2019 Prakash. All rights reserved.
//


import Alamofire
import SVProgressHUD

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, Error>)->Void) -> DataRequest {
        SVProgressHUD.show()
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                SVProgressHUD.dismiss()
                completion(response.result)
        }
    }
  
    static func refreshAccessToken(completion:@escaping (Result<AccessTokenModel, Error>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.refreshAccessToken(grant_type: APIHelper.APIParameteValues.grantType, username: APIHelper.APIParameteValues.username, password: APIHelper.APIParameteValues.password), decoder: jsonDecoder, completion: completion)
    }
    
    static func fetchSurveys(completion:@escaping (Result<[SurveyListModel], Error>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.fetchSurveys, decoder: jsonDecoder, completion: completion)
    }
}

