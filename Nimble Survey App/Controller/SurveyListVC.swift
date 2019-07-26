//
//  SurveyListVC.swift
//  Survey App
//
//  Created by PRAKASH on 7/24/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import UIKit

class SurveyListVC: UIPageViewController{
     var pageControl: UIPageControl = UIPageControl()
    var surveyListModels : [SurveyListModel]    =   []
    
    var currentPageIndex : Int  =   0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callWebservice()
        self.dataSource =   self
        self.delegate   =   self
        
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let pageControlWidth = CGFloat(30 * 2)
        let topSpace = self.navigationController!.navigationBar.bounds.size.height + 22
        let pageControlHeight = screenHeight - topSpace
        self.pageControl    =   UIPageControl.init()
        self.pageControl.frame  =   CGRect(x: screenWidth - pageControlWidth, y: topSpace, width: pageControlWidth, height: pageControlHeight)
        pageControl.transform = CGAffineTransform(scaleX: 3, y: 3)
        self.pageControl.transform = pageControl.transform.rotated(by: .pi/2)
        
        self.view.addSubview(pageControl)
    }
    
    
    func callWebservice(){
        if self.savedTokenDatas.accessToken != ""{
            let date = Date(timeIntervalSince1970: self.savedTokenDatas.createdAt)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = TimeZone(identifier: "en-US")
            let localDate = dateFormatter.string(from: date)
            
            let newDate =   dateFormatter.date(from: localDate)?.addingTimeInterval(self.savedTokenDatas.expiresIn)
            print("new date is:- \(dateFormatter.string(from: newDate!))")
            
            if Date() > dateFormatter.date(from: dateFormatter.string(from: newDate!))!{
                refreshAccessToken()
            }else{
                APIClient.fetchSurveys{ (result) in
                    print("check results:-\(result)")
                    switch result {
                    case .success(let modelSurveyList):
                        self.surveyListModels   =   modelSurveyList
                        print("check for count for models:- \(modelSurveyList.count)")
                        self.updatePageView()
                        
                        break
                        
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
            }
            
            
        }else{
            refreshAccessToken()
        }
    }
    
    func updatePageView(){
        self.pageControl.numberOfPages  =   surveyListModels.count
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
    
    func refreshAccessToken(){
        self.printAccessTokenDatas(tag: "BEFORE")
        APIClient.refreshAccessToken { (result) in
            print("check results:-\(result)")
            switch result {
            case .success(let modelAccessToken):
                self.savedTokenDatas    =   modelAccessToken
                self.printAccessTokenDatas(tag: "AFTER")
                self.callWebservice()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func printAccessTokenDatas(tag : String){
        print("\(tag)")
        print("access Token:- \(self.savedTokenDatas.accessToken)")
        print("Token type:- \(self.savedTokenDatas.tokenType)")
        print("expired in:- \(self.savedTokenDatas.expiresIn)")
        print("creates at:- \(self.savedTokenDatas.createdAt)")
        print("\(tag)")
    }
    
    @IBAction func actionRefresh(_ sender: Any) {
        callWebservice()
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination : SurveyDetailTVC =   segue.destination as! SurveyDetailTVC
        destination.modelSurvey =   self.surveyListModels[currentPageIndex]
    }
 

}


// MARK: - UIPageViewController DataSource and Delegate

extension SurveyListVC : UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 3
    }

    
    // MARK:- UIPageViewControllerDataSource Methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let pageContent: SurveyListImageVC = viewController as! SurveyListImageVC
        
        var index = pageContent.pageIndex
        
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        
        index   -=  1
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let pageContent: SurveyListImageVC = viewController as! SurveyListImageVC
        
        var index = pageContent.pageIndex
        
        if (index == NSNotFound)
        {
            return nil;
        }
        
        index   +=  1
        if (index == surveyListModels.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index: index)
    }
    
    // MARK:- Other Methods
    func getViewControllerAtIndex(index: NSInteger) -> SurveyListImageVC
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "SurveyListImageVC") as! SurveyListImageVC
        pageContentViewController.surveyListModel   =   surveyListModels[index]
        pageContentViewController.pageIndex = index
        pageContentViewController.delegateImageClass    =   self
        return pageContentViewController
    }
}

extension SurveyListVC : SurveyImageClassDelegate{
    func clickedOnbutton(pageIndex: Int) {
        self.performSegue(withIdentifier: "segueSurvey", sender: self)
    }
    
    func loadPageAt(pageIndex: Int) {
        currentPageIndex    =   pageIndex
        self.pageControl.currentPage    =   pageIndex
    }
}
