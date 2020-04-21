//
//  ChatModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/17.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//


import SwiftUI
import SendBirdSDK

enum MessageType {
    static let fileMessage = "fileMessage"
    static let userMessage = "userMessage"
    static let adminMessage = "adminMessage"
}

struct ChatModel: Hashable, Codable, Identifiable {
    public var id: Int64 = 0
    public var messageType: String = MessageType.userMessage
    public var message: String = "default message"
    public var channelUrl: String = "default url"
    public var fileUrl: String = "default file url"
    public var user: UserModel = UserModel()
    
}
