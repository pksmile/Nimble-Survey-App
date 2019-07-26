//
//  SurveyQuestion'sAnswerModel.swift
//  Nimble Survey App
//
//  Created by PRAKASH on 7/25/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import UIKit

struct AnswerModel:  Codable {
    let id, questionID: String
    let text: String?
    let helpText: JSONNull?
    let inputMaskPlaceholder, shortText: String?
    let isMandatory, isCustomerFirstName, isCustomerLastName, isCustomerTitle: Bool
    let isCustomerEmail, promptCustomAnswer: Bool
    let weight: JSONNull?
    let displayOrder: Int
    let displayType: DisplayType
    let inputMask: InputMask?
    let dateConstraint: String?
    let defaultValue: JSONNull?
    let responseClass: ResponseClass
    let referenceIdentifier: JSONNull?
    let score: Int?
    let alerts: [JSONAny]
    
    enum CodingKeys: String, CodingKey {
        case id
        case questionID = "question_id"
        case text
        case helpText = "help_text"
        case inputMaskPlaceholder = "input_mask_placeholder"
        case shortText = "short_text"
        case isMandatory = "is_mandatory"
        case isCustomerFirstName = "is_customer_first_name"
        case isCustomerLastName = "is_customer_last_name"
        case isCustomerTitle = "is_customer_title"
        case isCustomerEmail = "is_customer_email"
        case promptCustomAnswer = "prompt_custom_answer"
        case weight
        case displayOrder = "display_order"
        case displayType = "display_type"
        case inputMask = "input_mask"
        case dateConstraint = "date_constraint"
        case defaultValue = "default_value"
        case responseClass = "response_class"
        case referenceIdentifier = "reference_identifier"
        case score, alerts
    }
}
