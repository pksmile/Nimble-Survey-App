//
//  SurveyListModel.swift
//  Nimble Survey App
//
//  Created by PRAKASH on 7/25/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct SurveyListModel: Codable {
    let id, title, welcomeDescription: String
    let accessCodePrompt, thankEmailAboveThreshold, thankEmailBelowThreshold, footerContent: String?
    let isActive: Bool
    let coverImageURL: String
    let coverBackgroundColor: String?
    let type, createdAt, activeAt: String
    let inactiveAt: JSONNull?
    let surveyVersion: Int
    let shortURL: String?
    let languageList: [DefaultLanguage]
    let defaultLanguage: DefaultLanguage
    let tagList: String
    let isAccessCodeRequired, isAccessCodeValidRequired: Bool
    let accessCodeValidation: String?
    let theme: SurveyListThemeModel
    let questions: [QuestionModel]
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case welcomeDescription = "description"
        case accessCodePrompt = "access_code_prompt"
        case thankEmailAboveThreshold = "thank_email_above_threshold"
        case thankEmailBelowThreshold = "thank_email_below_threshold"
        case footerContent = "footer_content"
        case isActive = "is_active"
        case coverImageURL = "cover_image_url"
        case coverBackgroundColor = "cover_background_color"
        case type
        case createdAt = "created_at"
        case activeAt = "active_at"
        case inactiveAt = "inactive_at"
        case surveyVersion = "survey_version"
        case shortURL = "short_url"
        case languageList = "language_list"
        case defaultLanguage = "default_language"
        case tagList = "tag_list"
        case isAccessCodeRequired = "is_access_code_required"
        case isAccessCodeValidRequired = "is_access_code_valid_required"
        case accessCodeValidation = "access_code_validation"
        case theme, questions
    }
}

enum DefaultLanguage: String, Codable {
    case en = "en"
    case th = "th"
}







// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

//{
//    "id": "ed1d4f0ff19a56073a14",
//    "title": "ibis Bangkok Riverside",
//    "description": "We'd love to hear from you!",
//    "access_code_prompt": null,
//    "thank_email_above_threshold": "Dear {name},<br /><br />Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are thrilled that you enjoyed your time with us! If you have a moment, we would be greatly appreciate it if you could leave a short review on <a href=\"http://www.tripadvisor.com/Hotel_Review-g1188000-d624070-Reviews-Beach_Republic_The_Residences-Lamai_Beach_Maret_Ko_Samui_Surat_Thani_Province.html\">TripAdvisor</a>. It helps to spread the word and let others know about the Beach Republic Revolution!<br /><br />Thank you again and we look forward to welcoming you back soon.<br /><br />Sincerely,<br /><br />Beach Republic Team",
//    "thank_email_below_threshold": "Dear {name},<br /><br />Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are constantly striving to improve and your feedback allows us to help improve the experience for you on your next visit. Each survey is read individually by senior staff and discussed with the team in daily meetings.&nbsp;<br /><br />Thank you again and we look forward to welcoming you back soon.<br /><br />Sincerely,<br /><br />Beach Republic Team",
//    "footer_content": "<div>Beach Republic (Samui) Co.,Ltd.</div><div>176/34 M.4, T.Maret,&nbsp;A.Koh Samui,&nbsp;</div><div>Suratthani,&nbsp;84310<br />Thailand</div>",
//    "is_active": true,
//    "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_",
//    "cover_background_color": null,
//    "type": "Hotel",
//    "created_at": "2017-01-23T10:32:24.585+07:00",
//    "active_at": "2016-01-22T11:12:00.000+07:00",
//    "inactive_at": null,
//    "survey_version": 0,
//    "short_url": "ibis",
//    "language_list": [
//    "en"
//    ],
//    "default_language": "en",
//    "tag_list": "ibis",
//    "is_access_code_required": false,
//    "is_access_code_valid_required": false,
//    "access_code_validation": "",
//    "theme": {
//        "color_active": "#EE100C",
//        "color_inactive": "#3A3A3A",
//        "color_question": "#ffffff",
//        "color_answer_normal": "#000000",
//        "color_answer_inactive": "#FFFFFF"
//    },
//    "questions": [
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
//    },
