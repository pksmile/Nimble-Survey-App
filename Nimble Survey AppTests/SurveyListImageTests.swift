//
//  SurveyListImageTests.swift
//  Nimble Survey AppTests
//
//  Created by PRAKASH on 7/26/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import  XCTest
@testable import Nimble_Survey_App

class SurveyListImageTests: XCTestCase {
    
    
    var surveyListImageVC = SurveyListImageVC()
    var surveyListModel :   SurveyListModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        refreshAccessTokenIfNeeded()
        self.surveyListImageVC  =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyListImageVC") as! SurveyListImageVC
        self.surveyListImageVC.delegateImageClass   =   self
        
    }
    
    func refreshAccessTokenIfNeeded(){
        if savedTokenDatas.accessToken != ""{
            let date = Date(timeIntervalSince1970: savedTokenDatas.createdAt)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = TimeZone(identifier: "en-US")
            let localDate = dateFormatter.string(from: date)
            
            let newDate =   dateFormatter.date(from: localDate)?.addingTimeInterval(savedTokenDatas.expiresIn)
            
            if Date() > dateFormatter.date(from: dateFormatter.string(from: newDate!))!{
                refreshAccessToken()
            }
        }else{
            refreshAccessToken()
        }
    }
    func refreshAccessToken(){
        
        APIClient.refreshAccessToken { (result) in
            switch result {
            case .success(let modelAccessToken):
                savedTokenDatas    =   modelAccessToken
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    func test_checkView(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server")
        
        APIClient.fetchSurveys{ (result) in
            switch result {
            case .success(let modelSurveyList):
                self.surveyListImageVC.surveyListModel = modelSurveyList[0]
                self.surveyListImageVC.loadViewIfNeeded()
                self.surveyListImageVC.setViewDatas()
                XCTAssertEqual(self.surveyListImageVC.labelTitle.text, modelSurveyList[0].title)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 21.0)
    }
    
    func test_clickOnTakeSurvey(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server and checking for Take Survey button click")
        
        APIClient.fetchSurveys{ (result) in
            switch result {
            case .success(let modelSurveyList):
                self.surveyListImageVC.surveyListModel = modelSurveyList[0]
                self.surveyListImageVC.loadViewIfNeeded()
                self.surveyListImageVC.actionTakeSurvey(self.surveyListImageVC.buttonTakeSurvey!)
               XCTAssertNotNil(self.surveyListImageVC.delegateImageClass.clickedOnbutton(pageIndex: 0))
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 21.0)
    }
    
    func test_descriptionLabelDynamicSize(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server and checking for view did load")
        APIClient.fetchSurveys{ (result) in
            switch result {
            case .success(let modelSurveyList):
                self.surveyListImageVC.surveyListModel = modelSurveyList[0]
                self.surveyListImageVC.loadViewIfNeeded()
               self.surveyListImageVC.viewDidLoad()
                XCTAssertNotNil(self.surveyListImageVC.labelDescription)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 21.0)
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


extension SurveyListImageTests : SurveyImageClassDelegate{
    //delegate from survey from image class
    func loadPageAt(pageIndex: Int) {
        print("check for loaded page:- \(pageIndex)")
    }
    func clickedOnbutton(pageIndex: Int) {
        print("check for clicked on button:- \(pageIndex)")
    }
}
