//
//  UserModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/01.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct UserModel: Hashable, Codable, Identifiable {
    public var id: String
    public var name: String
}
