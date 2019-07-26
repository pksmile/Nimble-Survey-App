//
//  SavedValues.swift
//  Nimble Survey App
//
//  Created by PRAKASH on 7/25/19.
//  Copyright © 2019 Prakash. All rights reserved.
//
//com.Nimble-Survey-App
import UIKit

extension UIViewController {
    var savedTokenDatas: AccessTokenModel{
        get {
            let userD : UserDefaults = UserDefaults.standard
            if let savedToken = userD.object(forKey: SavedAccessTokenDatasKey) as? Data {
                let decoder = JSONDecoder()
                if let loadedTokenData = try? decoder.decode(AccessTokenModel.self, from: savedToken) {
                    return loadedTokenData
                }
            }
            return AccessTokenModel(accessToken: "", tokenType: "", expiresIn: 0, createdAt: 0)
        }
        set(newVal) {
            let userD : UserDefaults = UserDefaults.standard
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newVal) {
                userD.set(encoded, forKey: SavedAccessTokenDatasKey)
                userD.synchronize()
            }
        }
    }
}
