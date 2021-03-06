//
//  OpenChannelModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/07.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation

struct OpenChannelModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var channelUrl: String
    var coverUrl: String
}
