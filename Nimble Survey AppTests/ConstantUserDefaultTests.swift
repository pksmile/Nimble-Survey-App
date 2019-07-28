//
//  ConstantUserDefaultTests.swift
//  Nimble Survey AppTests
//
//  Created by PRAKASH on 7/26/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import XCTest
@testable import Nimble_Survey_App

class ConstantUserDefaultTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_SaveTokenDatasNeverNil(){
        XCTAssertNotNil(savedTokenDatas)
    }
    
    func test_storeAndVerifyTokenData(){
        let tempSavedTokenData  =   savedTokenDatas
        let accessToken = "123456"
        savedTokenDatas = AccessTokenModel(accessToken: accessToken, tokenType: "test", expiresIn: 3000, createdAt: 42323233)
        XCTAssertTrue(accessToken == savedTokenDatas.accessToken)
        //updated token data by old value, so this test case should not effect the old value of stored data
        savedTokenDatas = tempSavedTokenData
    }
    
    func test_accessTokenDataAtStart(){
        let tempSavedTokenData  =   savedTokenDatas
        //remove any value associated with that data to check teh initial state of app
        UserDefaults.standard.removeObject(forKey: SavedAccessTokenDatasKey)
        XCTAssertTrue(savedTokenDatas.accessToken.isEmpty)
        //updated token data by old value, so this test case should not effect the old value of stored data
        savedTokenDatas = tempSavedTokenData
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
