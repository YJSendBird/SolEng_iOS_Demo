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

class ChatModel: Codable, Identifiable {

    static func == (lhs: ChatModel, rhs: ChatModel) -> Bool {
        if (lhs.id == rhs.id) {
            return true
        }
        return false
    }

    var id: Int64 = 0
    var messageType: String = MessageType.userMessage
    var message: String = "default message"
    var channelUrl: String = "default url"
    var fileUrl: String = "default file url"
    var user: UserModel = UserModel()
    
    func setMessage(sbMessage: SBDBaseMessage) {

        id = sbMessage.messageId

        channelUrl = sbMessage.channelUrl!

        if sbMessage is SBDUserMessage {
            
            let userMessage =  (sbMessage as? SBDUserMessage)
            
            messageType = MessageType.userMessage
            message = userMessage!.message!
            
            if(SBDMain.getCurrentUser() == userMessage!.sender!) {
                user.isCurrentUser = true
            } else {
                user.isCurrentUser = false
            }
            
        } else if sbMessage is SBDFileMessage {
            
            let fileMessage =  (sbMessage as? SBDFileMessage)
            
             messageType = MessageType.fileMessage
            fileUrl = fileMessage!.url
            
            if(SBDMain.getCurrentUser() == fileMessage!.sender!) {
                user.isCurrentUser = true
            } else {
                user.isCurrentUser = false
            }
            
        } else if sbMessage is SBDAdminMessage {
             messageType = MessageType.adminMessage
            message = (sbMessage as? SBDAdminMessage)!.message!
        }
        

    }
}
