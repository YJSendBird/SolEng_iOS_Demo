//
//  CXCallControllerManager.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import CallKit
import SendBirdCalls

class CXCallControllerManager {
    static let sharedController = CXCallController()
    
    static func requestTransaction(_ transaction: CXTransaction, action: String = "") {
        self.sharedController.request(transaction) { error in
            guard error == nil else { return }
            
            // Requested transaction successfully
        }
    }
}
