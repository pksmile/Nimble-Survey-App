//
//  SurveyListImageVC.swift
//  Nimble Survey App
//
//  Created by PRAKASH on 7/25/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import UIKit
import SDWebImage

protocol SurveyImageClassDelegate {
    func clickedOnbutton(pageIndex : Int)
    func loadPageAt(pageIndex : Int)
}

class SurveyListImageVC: UIViewController {

    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var delegateImageClass : SurveyImageClassDelegate!
    
    var pageIndex: Int = 0
    var surveyListModel : SurveyListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDescription.sizeToFit()
        self.setViewDatas()
        self.delegateImageClass.loadPageAt(pageIndex: self.pageIndex)
    }
    
    
    func setViewDatas(){
        self.labelTitle.text    =   surveyListModel.title
        self.labelDescription.text  =   surveyListModel.welcomeDescription
        self.imageView.sd_setImage(with: URL(string: surveyListModel.coverImageURL + "l"), completed: nil)
    }
    
    
    @IBAction func actionTakeSurvey(_ sender: Any) {
        delegateImageClass.clickedOnbutton(pageIndex: self.pageIndex)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
