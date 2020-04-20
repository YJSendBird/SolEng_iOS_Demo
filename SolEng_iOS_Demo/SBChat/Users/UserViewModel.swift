//
//  UserViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/01.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class UserViewModel {
    var users = [UserModel]() {
        didSet {
            didChange.send(self)
        }
    }
    
    let didChange = PassthroughSubject<UserViewModel, Never>()
}

