//
//  VideoCallModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/14.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation

struct VideoCallModel: Hashable, Codable, Identifiable {
    var id: String = ""
    public var timer: String = "00:00"
    public var userId: String = "userId"
    public var userName: String = ""
    public var avatar: String = ""
    public var remoteUserId: String = "userId"
    public var remoteUserName: String = "userId"
    public var remoteAvatar: String = "userId"
    public var isCalling: Bool = false
    public var isAudioEnable: Bool = true
    public var isSpeakerEnable: Bool = true
    public var isVideoEnable: Bool = true
}
