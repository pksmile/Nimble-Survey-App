//
//  APIRouterTextCase.swift
//  Nimble Survey AppTests
//
//  Created by PRAKASH on 7/26/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import  XCTest
import Alamofire
@testable import Nimble_Survey_App

class APIRouterTestCase: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func test_httpMethodForRefreshToken(){
        let routerValue = APIRouter.refreshAccessToken(grant_type: APIHelper.APIParameteValues.grantType, username: APIHelper.APIParameteValues.username, password: APIHelper.APIParameteValues.password)
        XCTAssertEqual(routerValue.urlRequest?.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func test_httpMethodForFetchSurveys(){
        let routerValue = APIRouter.fetchSurveys
        XCTAssertEqual(routerValue.urlRequest?.httpMethod, HTTPMethod.get.rawValue)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
