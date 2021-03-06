//
//  GroupChannelModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/09.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct GroupChannelModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var channelUrl: String
    var coverUrl: String
}
