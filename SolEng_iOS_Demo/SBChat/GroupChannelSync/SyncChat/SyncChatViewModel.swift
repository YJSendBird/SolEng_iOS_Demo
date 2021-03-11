//
//  SyncChatViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2021/02/22.
//  Copyright © 2021 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SendBirdSyncManager
import SendBirdSDK


class MessageCollectionDelegate: NSObject, SBSMMessageCollectionDelegate{
    
    var channelName: String?
    var chatViewModel : SyncChatViewModel?
    func setName(name: String, viewModel: SyncChatViewModel) {
        self.channelName = name
        self.chatViewModel = viewModel
    }
    
    func collection(_ collection: SBSMMessageCollection, didReceive action: SBSMMessageEventAction, pendingMessages: [SBDBaseMessage]) {
        print("MessageCollectionDelegate::pendingMessages::action " + action.rawValue.description + "/name = " + self.channelName!)
        for message in pendingMessages {
            print("MessageCollectionDelegate::pendingMessages:" + message.message)
        }
    }

    func collection(_ collection: SBSMMessageCollection, didReceive action: SBSMMessageEventAction, succeededMessages: [SBDBaseMessage]) {
        print("MessageCollectionDelegate::succeededMessages::action " + action.rawValue.description + "/name = " + self.channelName!)
        DispatchQueue.main.async {
            for message in succeededMessages {
                print("MessageCollectionDelegate::succeededMessages:" + message.message)
                self.chatViewModel?.lists.append(SBManager.convertToChatModel(sbMessage: message))
            }
        }
    }
    
    func collection(_ collection: SBSMMessageCollection, didReceive action: SBSMMessageEventAction, failedMessages: [SBDBaseMessage], reason: SBSMFailedMessageEventActionReason) {
        print("MessageCollectionDelegate::failedMessages::action " + action.rawValue.description + "/name = " + self.channelName!)
        for message in failedMessages {
            print("MessageCollectionDelegate::failedMessages:" + message.message)
        }
    }
}

final class SyncChatViewModel: ObservableObject {

    @Published var lists = [ChatModel]()

    var messageCollection: SBSMMessageCollection?
    var delegate = MessageCollectionDelegate()
    var groupChannel: SBDGroupChannel?
    var channelUrl:String?
    
    init(channelUrl: String) {
        self.channelUrl = channelUrl
        SBDGroupChannel.getWithUrl(self.channelUrl!, completionHandler: { [self] (groupChannel, error) in
            if(error != nil) {
                print("channelUrl = " + self.channelUrl! + " error :: " + error!.description as Any)
                return
            }
            let filter = SBSMMessageFilter(messageType: .all, customType: nil, senderUserIds: nil)
            self.messageCollection = SBSMMessageCollection(channel: groupChannel!, filter: filter, viewpointTimestamp: LLONG_MAX, limit: 20, reverse: false)
            self.groupChannel = groupChannel
            self.delegate.setName(name: self.groupChannel!.name, viewModel: self)
            self.messageCollection?.delegate = self.delegate
        })
    }
    
    deinit {
        if self.messageCollection != nil {
            self.messageCollection?.delegate = nil
            self.messageCollection?.remove()
            self.messageCollection = nil
        }
    }

    func sendMessage(message: String) {
        
        let params = SBDUserMessageParams(message: message)
        guard let paramsBinded: SBDUserMessageParams = params else {
            return
        }

        let pendingMessage = self.groupChannel?.sendUserMessage(with: paramsBinded, completionHandler: { (userMessage, error) in
            self.messageCollection?.handleSendMessageResponse(userMessage!, error)
        })

        self.messageCollection?.appendMessage(pendingMessage!)
    
    }

    func fetchMessage(){
        print("fetchMessage()")
        self.messageCollection?.fetch(in: .next, completionHandler: { (hasMore, error) in
            if let error = error {
                print(error.description)
                return
            }
        })
    }
}
