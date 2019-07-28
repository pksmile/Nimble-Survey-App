//
//  SurveyVCListTestCases.swift
//  Nimble Survey AppTests
//
//  Created by PRAKASH on 7/28/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import XCTest

@testable import Nimble_Survey_App
class SurveyListVCTestCases: XCTestCase {
    
    var surveyListVC = SurveyListVC()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.surveyListVC  =   (UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationClass") as! UINavigationController).viewControllers[0] as! SurveyListVC
        self.surveyListVC.navigationController?.loadViewIfNeeded()
        self.surveyListVC.loadViewIfNeeded()
    }
    
    func test_refreshTokenFunction(){
        self.surveyListVC.refreshAccessToken()
        //Assuming after 12 seconds it must fetch data from backend
        wait(interval: 12) {
            XCTAssertNotNil(savedTokenDatas.accessToken)
        }
    }
    
    
    func test_clickOnButtonNext(){
        self.surveyListVC.callWebservice()
        wait(interval: 15) {
            self.surveyListVC.clickedOnbutton(pageIndex: 0)
            XCTAssertTrue(self.surveyListVC.navigationController?.topViewController is SurveyListVC)
        }
        
    }
    
    func test_BeforeVC_PageVC(){
        self.surveyListVC.callWebservice()
        wait(interval: 15) {
            self.surveyListVC.loadViewIfNeeded()
            let viewControllerAt0   =   self.surveyListVC.pageViewController(self.surveyListVC, viewControllerBefore: self.surveyListVC.getViewControllerAtIndex(index: 1))
            XCTAssertNotEqual(viewControllerAt0!, self.surveyListVC.getViewControllerAtIndex(index: 0))
        }
        
    }
    
    func test_AfterVC_PageVC(){
        self.surveyListVC.callWebservice()
        wait(interval: 15) {
            self.surveyListVC.loadViewIfNeeded()
            let viewControllerAt1   =   self.surveyListVC.pageViewController(self.surveyListVC, viewControllerAfter: self.surveyListVC.getViewControllerAtIndex(index: 0))
            XCTAssertNotEqual(viewControllerAt1!, self.surveyListVC.getViewControllerAtIndex(index: 1))
        }
        
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
