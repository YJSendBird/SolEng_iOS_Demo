//
//  VoiceCallModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/14.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct VoiceCallModel: Hashable, Codable, Identifiable {
    var id: String = ""
    public var userId: String = ""
    public var userName: String = ""
    public var avatar: String = ""
    public var isDialing: Bool = false
}

