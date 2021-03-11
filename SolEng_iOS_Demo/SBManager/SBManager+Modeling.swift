//
//  SBManager+Extension.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/20.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SendBirdSDK

extension SBManager {

    static func convertToChatModel(sbMessage: SBDBaseMessage) -> ChatModel {

        var model = ChatModel()
        
        model.id = sbMessage.messageId

        model.channelUrl = sbMessage.channelUrl

        if sbMessage is SBDUserMessage {
            
            let userMessage =  (sbMessage as? SBDUserMessage)
            
            model.messageType = MessageType.userMessage
            model.message = userMessage!.message
            
            if(SBDMain.getCurrentUser() == userMessage!.sender!) {
                model.user.isCurrentUser = true
            } else {
                model.user.isCurrentUser = false
                model.user.avatar = userMessage!.sender!.profileUrl!
            }
            
        } else if sbMessage is SBDFileMessage {
            
            let fileMessage =  (sbMessage as? SBDFileMessage)
            
            model.messageType = MessageType.fileMessage
            model.fileUrl = fileMessage!.url
            
            if(SBDMain.getCurrentUser() == fileMessage!.sender!) {
                model.user.isCurrentUser = true
            } else {
                model.user.isCurrentUser = false
                model.user.avatar = fileMessage!.sender!.profileUrl!
            }
            
        } else if sbMessage is SBDAdminMessage {
            model.messageType = MessageType.adminMessage
            model.message = (sbMessage as? SBDAdminMessage)!.message
        }
        return model
    }
}
