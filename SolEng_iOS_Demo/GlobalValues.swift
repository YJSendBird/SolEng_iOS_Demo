//
//  GlobalValues.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/23.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import Combine

class GlobalValues: ObservableObject {
    static let sharedInstance = GlobalValues()

    let userIdString = PassthroughSubject<String, Never>()

    var userId: String {
        get {
            return UserDefaults.standard.string(forKey: "userId") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
            self.userIdString.send(newValue)
        }
    }
    
}

