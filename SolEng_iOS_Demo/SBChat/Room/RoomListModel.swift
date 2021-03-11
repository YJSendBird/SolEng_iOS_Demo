//
//  RoomListModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2021/03/11.
//  Copyright © 2021 YongjunChoi. All rights reserved.
//

import Foundation

struct RoomlListModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var roomId: String
    var coverUrl: String
}
