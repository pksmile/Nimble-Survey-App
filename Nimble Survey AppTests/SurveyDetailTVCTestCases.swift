//
//  SurveyDetailTVCTestCases.swift
//  Nimble Survey AppTests
//
//  Created by PRAKASH on 7/28/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import XCTest

@testable import Nimble_Survey_App

class SurveyDetailTVCTestCases: XCTestCase {
    var surveyListVC = SurveyListVC()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.surveyListVC  =   (UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationClass") as! UINavigationController).viewControllers[0] as! SurveyListVC
        self.surveyListVC.navigationController?.loadViewIfNeeded()
        self.surveyListVC.loadViewIfNeeded()
    }
    
    func test_numberOfSectionInSurveyDetailVC(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server")
        getSurveyDatas { (surveyModel) in
            let detailVC    =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyDetailTVC") as! SurveyDetailTVC
           detailVC.modelSurvey =   surveyModel
            self.surveyListVC.navigationController?.pushViewController(detailVC, animated: true)
            XCTAssertEqual(detailVC.numberOfSections(in: detailVC.tableView), surveyModel.questions.count)
            
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 21.0)
    }
    func test_numberOfRowsInSurveyDetailVC(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server")
        getSurveyDatas { (surveyModel) in
            let detailVC    =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyDetailTVC") as! SurveyDetailTVC
            detailVC.modelSurvey =   surveyModel
            self.surveyListVC.navigationController?.pushViewController(detailVC, animated: true)
            let section =   0
            XCTAssertEqual(detailVC.tableView(detailVC.tableView, numberOfRowsInSection: section), surveyModel.questions[section].answers.count)
            
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 21.0)
    }
    
    func test_CellForRow_InSurveyDetailVC(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server")
        getSurveyDatas { (surveyModel) in
            let detailVC    =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyDetailTVC") as! SurveyDetailTVC
            detailVC.modelSurvey =   surveyModel
            self.surveyListVC.navigationController?.pushViewController(detailVC, animated: true)
            let section =   0
            let row     =   0
            let cell    =   detailVC.tableView(detailVC.tableView, cellForRowAt: IndexPath(row: row, section: section))
            let question    =   surveyModel.questions[section]
            var answerTitle =   ""
            if question.answers.count > 0{
                answerTitle   =   question.answers[row].text ?? ""
            }
            XCTAssertEqual(cell.textLabel?.text, answerTitle)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 21.0)
    }
    
    func test_CellForRow_nonEmptyAnswer_InSurveyDetailVC(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server")
        getSurveyDatas { (surveyModel) in
            let detailVC    =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyDetailTVC") as! SurveyDetailTVC
            detailVC.modelSurvey =   surveyModel
            self.surveyListVC.navigationController?.pushViewController(detailVC, animated: true)
            var section =   0
            var question    =   surveyModel.questions[section]
            var answerTitle =   ""
            while question.answers.count    >   0{
                section +=  1
                //to prevent crash in case no question contains the answe array
                if surveyModel.questions.count  == section{
                    section -=  1
//                    break
                }
                question    =   surveyModel.questions[section]
            }
            if question.answers.count > 0{
                answerTitle   =   question.answers[section].text ?? ""
            }
            
            
            let cell    =   detailVC.tableView(detailVC.tableView, cellForRowAt: IndexPath(row: section, section: section))
            
            XCTAssertEqual(cell.textLabel?.text, answerTitle)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 21.0)
    }
    
    func test_actionBack(){
        let detailVC    =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyDetailTVC") as! SurveyDetailTVC
        self.surveyListVC.navigationController?.pushViewController(detailVC, animated: true)
        detailVC.loadViewIfNeeded()
        detailVC.actionBack(detailVC.buttonBack)
        XCTAssertFalse(self.surveyListVC.navigationController?.topViewController is SurveyDetailTVC)
    }
    
    
    
    func getSurveyDatas(completion:@escaping (_ modelData : SurveyListModel)->Void){
        
        refreshAccessTokenIfNeeded {
            APIClient.fetchSurveys{ (result) in
                switch result {
                case .success(let modelSurveyList):
                    completion(modelSurveyList[0])
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func refreshAccessTokenIfNeeded(completion:@escaping ()->Void){
        if savedTokenDatas.accessToken != ""{
            let date = Date(timeIntervalSince1970: savedTokenDatas.createdAt)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = TimeZone(identifier: "en-US")
            let localDate = dateFormatter.string(from: date)
            
            let newDate =   dateFormatter.date(from: localDate)?.addingTimeInterval(savedTokenDatas.expiresIn)
            
            if Date() > dateFormatter.date(from: dateFormatter.string(from: newDate!))!{
                refreshAccessToken(){
                    completion()
                }
            }else{
                completion()
            }
        }else{
            refreshAccessToken(){
                completion()
            }
        }
    }
    
    func refreshAccessToken(completion:@escaping ()->Void){
        
        APIClient.refreshAccessToken { (result) in
            switch result {
            case .success(let modelAccessToken):
                savedTokenDatas    =   modelAccessToken
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    
    func test_refreshTokenFunction(){
        self.surveyListVC.refreshAccessToken()
        //Assuming after 12 seconds it must fetch data from backend
        wait(interval: 12) {
            XCTAssertNotNil(savedTokenDatas.accessToken)
        }
    }
    
    
    func test_didSelectRowAtIndexPath(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server")
        getSurveyDatas { (surveyModel) in
            let detailVC    =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyDetailTVC") as! SurveyDetailTVC
            detailVC.modelSurvey =   surveyModel
            self.surveyListVC.navigationController?.pushViewController(detailVC, animated: true)
            let indexPath = IndexPath(row: 0, section: 0)
            detailVC.tableView(detailVC.tableView, didSelectRowAt: indexPath)
            XCTAssertNotEqual(detailVC.tableView.indexPathForSelectedRow, indexPath, "Added not equal to method because as soon as table view cell selected, code is deselcting the cell")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 21.0)
    }
    
    func test_titleForHeader(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server")
        getSurveyDatas { (surveyModel) in
            let detailVC    =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyDetailTVC") as! SurveyDetailTVC
            detailVC.modelSurvey =   surveyModel
            self.surveyListVC.navigationController?.pushViewController(detailVC, animated: true)
            let section = 0
            XCTAssertEqual(detailVC.tableView(detailVC.tableView, titleForHeaderInSection: section), surveyModel.questions[0].text)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 21.0)
    }
    
    func test_heightForHeader(){
        let expectation = XCTestExpectation(description: "Fetching one survey data from server")
        getSurveyDatas { (surveyModel) in
            let detailVC    =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyDetailTVC") as! SurveyDetailTVC
            detailVC.modelSurvey =   surveyModel
            self.surveyListVC.navigationController?.pushViewController(detailVC, animated: true)
            let section = 0
            XCTAssertEqual(detailVC.tableView(detailVC.tableView, heightForHeaderInSection: section), UITableView.automaticDimension)
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
