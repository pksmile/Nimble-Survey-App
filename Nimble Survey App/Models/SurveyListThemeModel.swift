//
//  SurveyListThemeModel.swift
//  Nimble Survey App
//
//  Created by PRAKASH on 7/25/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import UIKit

struct SurveyListThemeModel: Codable {
    let colorActive, colorInactive: String
    let colorQuestion: ColorQuestion
    let colorAnswerNormal, colorAnswerInactive: String
    
    enum CodingKeys: String, CodingKey {
        case colorActive = "color_active"
        case colorInactive = "color_inactive"
        case colorQuestion = "color_question"
        case colorAnswerNormal = "color_answer_normal"
        case colorAnswerInactive = "color_answer_inactive"
    }
}

enum ColorQuestion: String, Codable {
    case ffffff = "#ffffff"
}


//"theme": {
////        "color_active": "#EE100C",
////        "color_inactive": "#3A3A3A",
////        "color_question": "#ffffff",
////        "color_answer_normal": "#000000",
////        "color_answer_inactive": "#FFFFFF"
////    },
