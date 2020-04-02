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
    
    init () {
        fetchUser()
    }
    
    var users = [UserModel]() {
        didSet {
            didChange.send(self)
        }
    }
    
    private func fetchUser() {
        SBManager.shared().getUsers { (userItems) in
            for user in userItems {
                print("username = %s", user.name)
                self.users.append(user)
            }
        }
    }
    
    let didChange = PassthroughSubject<UserViewModel, Never>()
}

