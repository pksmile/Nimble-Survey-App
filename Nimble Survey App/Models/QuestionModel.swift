//
//  SurveyListQuestionModel.swift
//  Nimble Survey App
//
//  Created by PRAKASH on 7/25/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import UIKit

struct QuestionModel: Codable {
    let id, text: String
    let helpText: String?
    let displayOrder: Int
    let shortText: String
    let pick: Pick
    let displayType: String
    let isMandatory: Bool
    let correctAnswerID: JSONNull?
    let facebookProfile, twitterProfile, imageURL: String?
    let coverImageURL: String
    let coverImageOpacity: Double?
    let coverBackgroundColor: String?
    let isShareableOnFacebook, isShareableOnTwitter: Bool
    let fontFace: String?
    let fontSize: JSONNull?
    let tagList: String
    let answers: [AnswerModel]
    let dependency: Dependency?
    
    enum CodingKeys: String, CodingKey {
        case id, text
        case helpText = "help_text"
        case displayOrder = "display_order"
        case shortText = "short_text"
        case pick
        case displayType = "display_type"
        case isMandatory = "is_mandatory"
        case correctAnswerID = "correct_answer_id"
        case facebookProfile = "facebook_profile"
        case twitterProfile = "twitter_profile"
        case imageURL = "image_url"
        case coverImageURL = "cover_image_url"
        case coverImageOpacity = "cover_image_opacity"
        case coverBackgroundColor = "cover_background_color"
        case isShareableOnFacebook = "is_shareable_on_facebook"
        case isShareableOnTwitter = "is_shareable_on_twitter"
        case fontFace = "font_face"
        case fontSize = "font_size"
        case tagList = "tag_list"
        case answers, dependency
    }
}


//"questions": [
//    {
//    "id": "fa385b75617d98e069a3",
//    "text": "Thank you for choosing ibis Bangkok Riverside!\nYour feedback is greatly appreciated and is read by management daily!",
//    "help_text": null,
//    "display_order": 0,
//    "short_text": "Welcome",
//    "pick": "none",
//    "display_type": "intro",
//    "is_mandatory": false,
//    "correct_answer_id": null,
//    "facebook_profile": null,
//    "twitter_profile": null,
//    "image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/16ff8eb705e0de12b15e_",
//    "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_",
//    "cover_image_opacity": 0.63,
//    "cover_background_color": null,
//    "is_shareable_on_facebook": false,
//    "is_shareable_on_twitter": false,
//    "font_face": null,
//    "font_size": null,
//    "tag_list": "",
//    "answers": [
//    {
//    "id": "7f82e73157e54a23d876",
//    "question_id": "b8f06895134eb1da2d13",
//    "text": null,
//    "help_text": null,
//    "input_mask_placeholder": null,
//    "short_text": "answer_1",
//    "is_mandatory": false,
//    "is_customer_first_name": false,
//    "is_customer_last_name": false,
//    "is_customer_title": false,
//    "is_customer_email": false,
//    "prompt_custom_answer": false,
//    "weight": null,
//    "display_order": 0,
//    "display_type": "default",
//    "input_mask": null,
//    "date_constraint": null,
//    "default_value": null,
//    "response_class": "text",
//    "reference_identifier": null,
//    "score": null,
//    "alerts": []
//    }
//    ]
