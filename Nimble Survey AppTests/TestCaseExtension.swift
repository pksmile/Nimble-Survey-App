//
//  TestCaseExtension.swift
//  Nimble Survey AppTests
//
//  Created by PRAKASH on 7/28/19.
//  Copyright © 2019 Prakash. All rights reserved.
//

import XCTest

extension XCTestCase {
    func wait(interval: TimeInterval = 0.1 , completion: @escaping (() -> Void)) {
        let exp = expectation(description: "Dispatch method from testcase")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
            exp.fulfill()
        }
        waitForExpectations(timeout: interval + 0.1) // add 0.1 for sure asyn after called
    }
}
