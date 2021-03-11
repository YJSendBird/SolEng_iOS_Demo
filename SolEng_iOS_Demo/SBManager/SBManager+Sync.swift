//
//  SBManager+Sync.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/05/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SendBirdCalls
import AVKit
import CallKit
import MediaPlayer
import SendBirdSyncManager

extension SBManager : SBSMChannelCollectionDelegate, SBSMMessageCollectionDelegate  {
    // MARK: - group channel with syncmanager
    public func initGroupChanneSync() {
        // Mark: - GroupChannel
        self.gropuChannelSyncModel.lists.removeAll()
        if groupChannelSyncQuery == nil {
            groupChannelSyncQuery = SBDGroupChannel.createMyGroupChannelListQuery()!
            groupChannelSyncQuery!.limit = 100
            groupChannelSyncQuery!.order = SBDGroupChannelListOrder.latestLastMessage
            groupCollection = SBSMChannelCollection(query: groupChannelSyncQuery!)
            if groupCollection != nil {
                groupCollection!.delegate = self
                groupCollection!.fetch(completionHandler: { (error) in
                     if error != nil {
                         print(error?.debugDescription as Any)
                     }
                })
            }
        }
    }
    
    // MARK - initSyncMessageCollection
//    func initSyncMessageCollection(channelUrl:String, completion: @escaping(Bool) -> ()) {
//        print("initSyncMessageCollection")
//        SBDGroupChannel.getWithUrl(channelUrl, completionHandler: { (groupChannel, error) in
//            guard error == nil else {   // Error.
//                return
//            }
//
//            self.chatModel.lists.removeAll()
//
//            let filter = SBSMMessageFilter(messageType: .all, customType: nil, senderUserIds: nil)
//            self.messageCollection = SBSMMessageCollection(channel: groupChannel!, filter: filter, viewpointTimestamp: LLONG_MAX)
//            self.messageCollection!.delegate = self
//
//            self.loadPreviousSyncMessage(collection:self.messageCollection!, completion: completion)
//        })
//    }
//
//    func loadPreviousSyncMessage(collection:SBSMMessageCollection?, completion: @escaping(Bool) -> ()){
//        //print("loadPreviousSyncMessage")
//        collection!.fetch(in: .previous, completionHandler: { (hasMore, error) in
//            if let error = error {
//                print(error.description)
//                completion(false)
//                return
//            }
//
//            if hasMore {
//                self.loadPreviousSyncMessage(collection:collection!, completion: completion)
//            } else {
//                if collection != nil {
//                    self.loadNextSyncMessage(collection:collection!, completion: completion)
//                }
//            }
//            /*
//            self.messageCollection!.fetch(in: .next, completionHandler: { (hasMore, error) in
//                completion(true)
//            })
//            */
//        })
//    }
//    func loadNextSyncMessage(collection:SBSMMessageCollection?, completion: @escaping(Bool) -> ()) {
//        //print("loadNextSyncMessage")
//        self.messageCollection!.fetchAllNextMessages { hasMore, error in
//            if let error = error {
//                print(error.description)
//                completion(false)
//                return
//            }
//
//            if hasMore {
//                self.loadNextSyncMessage(collection:collection!, completion: completion)
//            } else {
//                completion(true)
//            }
//        }
//    }
    
    
    //MARK: - SBSMChannelCollectionDelegate
    func collection(_ collection: SBSMChannelCollection, didReceiveEvent action: SBSMChannelEventAction, channels: [SBDGroupChannel]) {
        DispatchQueue.main.async {
            switch (action) {
                case .insert:
                    // TODO: Add channels to the view.
                    for channel in channels {
                        print("didReceive::SBSMChannelCollection insert =", channel.channelUrl)
                        self.gropuChannelSyncModel.lists.append(GroupChannelSyncModel(id: channel.channelUrl, name: channel.name, channelUrl: channel.channelUrl, coverUrl: channel.coverUrl!))
                    }
                    break
                case .update:
                    // TODO: Update channels to the view.
                    /*
                    for channel in channels {
                        print("didReceive::SBSMChannelCollection update =", channel.channelUrl)
                        self.gropuChannelSyncModel.lists.removeAll(where: { channel.channelUrl == $0.channelUrl})
                        self.gropuChannelSyncModel.lists.append(GroupChannelSyncModel(id: channel.channelUrl, name: channel.name, channelUrl: channel.channelUrl, coverUrl: channel.coverUrl!))
                    }*/
                    break
                case .remove:
                    // TODO: Remove channels from the view.
                    print("didReceive::SBSMChannelCollection remove")
                    for channel in channels {
                        print("didReceive::SBSMChannelCollection remove =", channel.channelUrl)
                        self.gropuChannelSyncModel.lists.removeAll(where: { channel.channelUrl == $0.channelUrl})
                    }
                    break
                case .move:
                    // TODO: Change the position of channels in the view.
                    /*
                    for channel in channels {
                        print("didReceive::SBSMChannelCollection move =", channel.channelUrl)
                        self.gropuChannelSyncModel.lists.removeAll(where: { channel.channelUrl == $0.channelUrl})
                        self.gropuChannelSyncModel.lists.append(GroupChannelSyncModel(id: channel.channelUrl, name: channel.name, channelUrl: channel.channelUrl, coverUrl: channel.coverUrl!))
                    }*/
                    break
                case .clear:
                    // TODO: Clear the view.
                    print("didReceive::SBSMChannelCollection clear")
                    break
                case .none:
                    print("didReceive::SBSMChannelCollection none")
                    break;
            @unknown default:
                print("action default")
            }
        }
    }
    
    //MARK: - SBSMMessageCollectionDelegate
    func collection(_ collection: SBSMMessageCollection, didRemove channel: SBDGroupChannel) {
        // TODO: Close View.
        print("SBSMMessageCollection::didRemove")
    }
    
    func collection(_ collection: SBSMMessageCollection, didUpdate channel: SBDGroupChannel) {
        // TODO: Update channel.
        print("SBSMMessageCollection::didUpdate")
    }
    
    func collection(_ collection: SBSMMessageCollection, didReceiveNewMessage message: SBDBaseMessage) {
        // TODO: Show something to notify the real-time message has been arrived!
        print("SBSMMessageCollection::didReceiveNewMessage")
        /*
        UserNotiRegister.shared().registUserNoti(sbMessage: message)
        DispatchQueue.main.async {
            self.chatModel.lists.append(SBManager.convertToChatModel(sbMessage: message))
        }
        */
    }
    
    func collection(_ collection: SBSMMessageCollection, didReceive action: SBSMMessageEventAction, pendingMessages: [SBDBaseMessage]) {
        DispatchQueue.main.async {
            
            switch (action) {
                case .insert:
                    // TODO: Add messages to the view.
                    print("SBSMMessageCollection::pendingMessages::insert")
                break
                case .update:
                    // TODO: Update messages in the view.
                    print("SBSMMessageCollection::pendingMessages::update")
                    break
                case .remove:
                    // TODO: Remove messages from the view.
                    print("SBSMMessageCollection::pendingMessages::remove")
                    break
                case .clear:
                    // TODO: Clear the view.
                    print("SBSMMessageCollection::pendingMessages::clear")
                    break
                case .none:
                    // Pass
                    print("SBSMMessageCollection::pendingMessages::none")
                    break
            @unknown default:
                print("default")
            }
        }
    }

    func collection(_ collection: SBSMMessageCollection, didReceive action: SBSMMessageEventAction, succeededMessages: [SBDBaseMessage]) {
        switch action {
        case .insert:
            print("SBSMMessageCollection::succeededMessages::insert")
            DispatchQueue.main.async {
                for message in succeededMessages {
                    print("SBSMMessageCollection::succeededMessages::message:" + message.message)
                    self.chatModel.lists.append(SBManager.convertToChatModel(sbMessage: message))
                }
            }
        case .update:
            print("SBSMMessageCollection::succeededMessages::update")
        case .remove:
            print("SBSMMessageCollection::succeededMessages::remove")
        case .clear:
            print("SBSMMessageCollection::succeededMessages::clear")
        case .none:
            print("SBSMMessageCollection::succeededMessages::none")
        default:
            print("SBSMMessageCollection::succeededMessages::default")
        }
    }
    
    func collection(_ collection: SBSMMessageCollection, didReceive action: SBSMMessageEventAction, failedMessages: [SBDBaseMessage], reason: SBSMFailedMessageEventActionReason) {
        switch action {
        case .insert:
            print("SBSMMessageCollection::failedMessages::insert")
        case .update:
            print("SBSMMessageCollection::failedMessages::update")
        case .remove:
            print("SBSMMessageCollection::failedMessages::remove")
        case .clear:
            print("SBSMMessageCollection::failedMessages::clear")
        case .none:
            print("SBSMMessageCollection::failedMessages::none")
        default:
            print("SBSMMessageCollection::failedMessages::default")
        }
    }
    
}
