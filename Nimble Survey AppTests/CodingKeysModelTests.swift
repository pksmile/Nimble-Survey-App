//
//  CodingKeysModelTests.swift
//  Nimble Survey AppTests
//
//  Created by PRAKASH on 7/28/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import XCTest

@testable import Nimble_Survey_App

class CodingKeysModelTests: XCTestCase {

        
    var jsonData : Data = Data()

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        readJsonFile()
    }
    
    func readJsonFile(){
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                jsonData    =   data
            } catch {
                // handle error
            }
        }
    }
    
    func test_JSONAny(){
        let jsonString = "{\"regex\":\".*\"}"
        let json = jsonString.data(using: .utf8)!
        
        let wrapper = try! JSONDecoder().decode(JSONAny.self, from: json)
        let encoded = try! JSONEncoder().encode(wrapper)
        
        let output = String(data: encoded, encoding: .utf8)!
        
        XCTAssertEqual(jsonString, output)
        
    }
    
    func test_JSONNull(){
        let jsonString = "\(NSNull.self)"
        let json = jsonString.data(using: .utf8)!
        var output : String?  =   nil
        let wrapper = try? JSONDecoder().decode(JSONNull.self, from: json)
        let encoded = try? JSONEncoder().encode(wrapper)
        if encoded  ==  nil{
            XCTAssertNil(output)
        }else{
            output = String(data: encoded!, encoding: .utf8)!
            XCTAssertEqual(jsonString, output)
        }
    }
    
    func test_decoding(){
        
        let surveyModel = try! JSONDecoder().decode(SurveyListModel.self, from: jsonData)
        
        XCTAssertEqual(surveyModel.title, "Scarlett Bangkok")
    }
    
    
    
    
    func testInvalidType() {
        let json = """
        {
         "regex": true
        }
        """.data(using: .utf8)!
        
        let wrapper = try? JSONDecoder().decode(SurveyListModel.self, from: json)
        
        XCTAssertNil(wrapper)
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
