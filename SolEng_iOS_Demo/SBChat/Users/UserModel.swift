//
//  UserModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/01.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct UserModel: Hashable, Codable, Identifiable {
    var id: String = "";
    var name: String = ""
    var avatar: String = ""
    var isCurrentUser: Bool = false
}
