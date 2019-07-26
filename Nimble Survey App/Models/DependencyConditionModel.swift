//
//  DependencyConditionModel.swift
//  Nimble Survey App
//
//  Created by PRAKASH on 7/25/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import UIKit

//class DependencyConditionModel: // MARK: - DependencyCondition
enum DisplayType: String, Codable {
    case displayTypeDefault = "default"
}

enum InputMask: String, Codable {
    case aZAZ09AZAZ09AZAZ09 = "[\\.\\-_\\+a-zA-Z0-9]+@[\\-\\a-zA-Z0-9]+(?:\\.[\\-a-zA-Z0-9]+)+"
    case the09613 = "\\+?[0-9]{6,13}"
}

enum ResponseClass: String, Codable {
    case answer = "answer"
    case integer = "integer"
    case string = "string"
    case text = "text"
}

// MARK: - Dependency
struct Dependency: Codable {
    let rule: String
    let id: Int
    let questionID: String
    let dependencyConditions: [DependencyCondition]
    
    enum CodingKeys: String, CodingKey {
        case rule, id
        case questionID = "question_id"
        case dependencyConditions = "dependency_conditions"
    }
}

struct DependencyCondition: Codable {
    let id: Int
    let ruleKey, dependencyConditionOperator: String
    let datetimeValue, integerValue, floatValue, unit: JSONNull?
    let textValue, stringValue, responseOther: JSONNull?
    let dependencyID: Int
    let questionID, answerID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ruleKey = "rule_key"
        case dependencyConditionOperator = "operator"
        case datetimeValue = "datetime_value"
        case integerValue = "integer_value"
        case floatValue = "float_value"
        case unit
        case textValue = "text_value"
        case stringValue = "string_value"
        case responseOther = "response_other"
        case dependencyID = "dependency_id"
        case questionID = "question_id"
        case answerID = "answer_id"
    }
}

enum Pick: String, Codable {
    case any = "any"
    case none = "none"
    case one = "one"
}
