//
//  SBManager.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/25.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SendBirdSyncManager
import SendBirdCalls
import SwiftUI

class SBManager: NSObject, SBDConnectionDelegate, SBDUserEventDelegate, SBDChannelDelegate, SBSMChannelCollectionDelegate {
    
    // MARK: - Properties
    static let UNIQUE_DELEGATE_ID = "SBManager"
    
    //static let APP_ID = "9DA1B1F4-0BE6-4DA8-82C5-2E81DAB56F23"        //Sample
    //static let APP_ID = "A5192321-42DA-4ADC-8A75-6311D24BF4FE"        //SendBird-Calls-Playground
    static let APP_ID = "521FF53A-352D-4802-A285-F176C21BB825"          //My Sample - With Call
    

    private var userListQuery:SBDApplicationUserListQuery?
    private var groupChannelSyncQuery:SBDGroupChannelListQuery?
    private var groupCollection: SBSMChannelCollection?
    private var groupChannelQuery:SBDGroupChannelListQuery?
    private var openChannelQuery:SBDOpenChannelListQuery?

    public var rootViewModel = RootViewModel()
    public var gropuChannelSyncModel = GroupChannelSyncViewModel()
    public var groupChannelModel = GroupChannelViewModel()
    public var openChannelModel = OpenChannelViewModel()
    public var userModel = UserViewModel()

    private static var sharedManager: SBManager = {
        let shared = SBManager()
        SBDMain.initWithApplicationId(SBManager.APP_ID)
        SendBirdCall.configure(appId: SBManager.APP_ID)
        return shared
    }()

    // MARK: - Accessors
    class func shared() -> SBManager {
        return sharedManager
    }

    public func addDelegate() {
        SBDMain.add(self as SBDChannelDelegate, identifier: SBManager.UNIQUE_DELEGATE_ID)
        SBDMain.add(self as SBDUserEventDelegate, identifier: SBManager.UNIQUE_DELEGATE_ID)
        SBDMain.add(self as SBDConnectionDelegate, identifier: SBManager.UNIQUE_DELEGATE_ID)
    }

    public func removeDelegate() {
        SBDMain.removeChannelDelegate(forIdentifier: SBManager.UNIQUE_DELEGATE_ID)
        SBDMain.removeUserEventDelegate(forIdentifier: SBManager.UNIQUE_DELEGATE_ID)
        SBDMain.removeConnectionDelegate(forIdentifier: SBManager.UNIQUE_DELEGATE_ID)
    }

    public func connect(userId: String, completion: @escaping(Bool) -> ()) {
        SBDMain.connect(withUserId: userId, completionHandler: { (user, error) in
            guard error == nil else {   // Error.
                print(error.debugDescription)
                completion(false)
                return
            }

            self.rootViewModel.userId = userId
            UserDefaults.standard.set(userId, forKey: "userId")
            self.initViewModel()
            self.syncViewModel()
            completion(true)
        })
    }

    public func logOut() {
        UserDefaults.standard.set("", forKey: "userId")
        self.rootViewModel.userId = ""
    }

    private func initViewModel() {
        print("initViewModel")
        //사용자 목록 업데이트
        print("initUsersListQuery")
        initUsersQuery()
        
        //채널 등록
        print("initGroupChannelSync")
        initGroupChanneSync()
        
        print("initGroupChannel")
        initGroupChannel()
        
        print("initOpenChannelListQuery")
        initOpenChannel()
    }
    
    private func syncViewModel() {
        print("getUsers")
        getUsers()
        
        print("getOpenChannels")
        getOpenChannels()
        
        print("getGroupChannels")
        getGroupChannels()
    }

    // MARK: - Users
    public func initUsersQuery() {
        self.userModel.users.removeAll()
        if self.userListQuery != nil {
            self.userListQuery = nil
        }
        self.userListQuery = SBDMain.createApplicationUserListQuery()
    }

    public func getUsers() {
        // Retrieving all users
        self.userListQuery?.loadNextPage(completionHandler: { (users, error) in
            guard error == nil else {   // Error.
                print(error.debugDescription)
                return
            }

            if self.userListQuery?.hasNext == true {
                for user in users! {
                    self.userModel.users.append(UserModel(id: user.userId, name: user.nickname!))
                }
                //반복해서 읽어오기
                self.getUsers()
            }
        })
    }

    // MARK: - group channel with syncmanager
    private func initGroupChanneSync() {
        // Mark: - GroupChannel
        if groupChannelSyncQuery == nil {
            groupChannelSyncQuery = SBDGroupChannel.createMyGroupChannelListQuery()!
            groupChannelSyncQuery!.limit = 10
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

    private func deinitChannel() {
        groupCollection?.remove()
        groupCollection!.delegate = self
    }

    // MARK: - group chanel
    private func initGroupChannel(){
        self.groupChannelModel.lists.removeAll()
        if groupChannelQuery == nil {
            groupChannelQuery = SBDGroupChannel.createMyGroupChannelListQuery()!
            groupChannelQuery?.limit = 20
        }
    }
    
    private func getGroupChannels() {
        groupChannelQuery!.loadNextPage(completionHandler: { (groupChannels, error) in
                guard error == nil else {   // Error.
                    print(error.debugDescription)
                    return
                }
            
                for channel in groupChannels! {
                    self.groupChannelModel.lists.append(GroupChannelModel(id: channel.channelUrl, name: channel.name))
                }
            
                if self.groupChannelQuery?.hasNext == true {
                    //반복해서 읽어오기
                    self.getGroupChannels()
                }
            })
    }

    // MARK: - open channel
    private func initOpenChannel() {
        self.openChannelModel.lists.removeAll()
        if openChannelQuery == nil {
            openChannelQuery = SBDOpenChannel.createOpenChannelListQuery()!
            openChannelQuery?.limit = 20
            let channelNameFilter = ""
            if channelNameFilter.count > 0 {
                self.openChannelQuery?.channelNameFilter = channelNameFilter
            }
        }
    }
    
    private func getOpenChannels() {
        openChannelQuery!.loadNextPage(completionHandler: { (openChannels, error) in
                guard error == nil else {   // Error.
                    print(error.debugDescription)
                    return
                }

                for channel in openChannels! {
                    self.openChannelModel.lists.append(OpenChannelModel(id: channel.channelUrl, name: channel.name))
                }

                if self.openChannelQuery?.hasNext == true {
                    //반복해서 읽어오기
                    self.getOpenChannels()
                }
            })
    }
    
    
    // MARK: - SBDConnectionDelegate
    func didStartReconnection() {
        print("SBDConnectionDelegate didStartReconnection")
    }

    func didSucceedReconnection() {
        syncViewModel()
    }

    func didFailReconnection() {
        print("SBDConnectionDelegate didFailReconnection")
    }
    
    func didCancelReconnection() {
        print("SBDConnectionDelegate didCancelReconnection")
    }
    
    // MARK: - SBDChannelDelegate
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        print("SBDConnectionDelegate didReceive")
    }

    func channel(_ sender: SBDBaseChannel, didUpdate message: SBDBaseMessage) {
        print("SBDConnectionDelegate didUpdate")
    }

    func channel(_ sender: SBDBaseChannel, messageWasDeleted messageId: Int64) {
        print("SBDConnectionDelegate messageWasDeleted")
    }

    func channel(_ channel: SBDBaseChannel, didReceiveMention message: SBDBaseMessage) {
        print("SBDConnectionDelegate didReceiveMention")
    }

    func channelWasChanged(_ sender: SBDBaseChannel) {
        print("SBDConnectionDelegate channelWasChanged")
    }

    func channelWasDeleted(_ channelUrl: String, channelType: SBDChannelType) {
        print("SBDConnectionDelegate channelWasDeleted")
    }

    func channelWasFrozen(_ sender: SBDBaseChannel) {
        print("SBDConnectionDelegate channelWasFrozen")
    }

    func channelWasUnfrozen(_ sender: SBDBaseChannel) {
        print("SBDConnectionDelegate channelWasUnfrozen")
    }

    func channel(_ sender: SBDBaseChannel, createdMetaData: [String : String]?) {
        print("SBDConnectionDelegate createdMetaData")
    }

    func channel(_ sender: SBDBaseChannel, updatedMetaData: [String : String]?) {
        print("SBDConnectionDelegate updatedMetaData")
    }

    func channel(_ sender: SBDBaseChannel, deletedMetaDataKeys: [String]?) {
        print("SBDConnectionDelegate deletedMetaDataKeys")
    }

    func channel(_ sender: SBDBaseChannel, createdMetaCounters: [String : NSNumber]?) {
        print("SBDConnectionDelegate createdMetaCounters")
    }

    func channel(_ sender: SBDBaseChannel, updatedMetaCounters: [String : NSNumber]?) {
        print("SBDConnectionDelegate updatedMetaCounters")
    }

    func channel(_ sender: SBDBaseChannel, deletedMetaCountersKeys: [String]?) {
        print("SBDConnectionDelegate deletedMetaCountersKeys")
    }

    func channelWasHidden(_ sender: SBDGroupChannel) {
        print("SBDConnectionDelegate channelWasHidden")
    }

    func channel(_ sender: SBDGroupChannel, didReceiveInvitation invitees: [SBDUser]?, inviter: SBDUser?) {
        print("SBDConnectionDelegate didReceiveInvitation")
    }

    func channel(_ sender: SBDGroupChannel, didDeclineInvitation invitee: SBDUser, inviter: SBDUser?) {
        print("SBDConnectionDelegate didDeclineInvitation")
    }

    func channel(_ sender: SBDGroupChannel, userDidJoin user: SBDUser) {
        print("SBDConnectionDelegate userDidJoin")
    }

    func channel(_ sender: SBDGroupChannel, userDidLeave user: SBDUser) {
        print("SBDConnectionDelegate userDidLeave")
    }

    func channelDidUpdateReadReceipt(_ sender: SBDGroupChannel) {
        print("SBDConnectionDelegate channelDidUpdateReadReceipt")
    }

    func channelDidUpdateTypingStatus(_ sender: SBDGroupChannel) {
        print("SBDConnectionDelegate channelDidUpdateTypingStatus")
    }

    func channel(_ sender: SBDOpenChannel, userDidEnter user: SBDUser) {
        print("SBDConnectionDelegate userDidEnter")
    }

    func channel(_ sender: SBDOpenChannel, userDidExit user: SBDUser) {
        print("SBDConnectionDelegate userDidExit")
    }

    func channel(_ sender: SBDBaseChannel, userWasMuted user: SBDUser) {
        print("SBDConnectionDelegate userWasMuted")
    }

    func channel(_ sender: SBDBaseChannel, userWasUnmuted user: SBDUser) {
        print("SBDConnectionDelegate userWasUnmuted")
    }

    func channel(_ sender: SBDBaseChannel, userWasBanned user: SBDUser) {
        print("SBDConnectionDelegate userWasBanned")
    }

    func channel(_ sender: SBDBaseChannel, userWasUnbanned user: SBDUser) {
        print("SBDConnectionDelegate userWasUnbanned")
    }
    
    // MARK: - SBDUserEventDelegate
    func didDiscoverFriends(_ friends: [SBDUser]?) {
        print("SBDConnectionDelegate didDiscoverFriends")
    }

    func didUpdateTotalUnreadMessageCount(_ totalCount: Int32, totalCountByCustomType: [String : NSNumber]?) {
        print("SBDConnectionDelegate didUpdateTotalUnreadMessageCount")
    }
    
    
    //MARK: - SBSMChannelCollectionDelegate
    func collection(_ collection: SBSMChannelCollection, didReceiveEvent action: SBSMChannelEventAction, channels: [SBDGroupChannel]) {
        switch (action) {
            case .insert:
                // TODO: Add channels to the view.
                print("SBSMChannelCollection insert")
                for channel in channels {
                    self.gropuChannelSyncModel.lists.append(GroupChannelSyncModel(id: channel.channelUrl, name: channel.name))
                }
                break
            case .update:
                // TODO: Update channels to the view.
                print("SBSMChannelCollection update")
                break
            case .remove:
                // TODO: Remove channels from the view.
                print("SBSMChannelCollection remove")
                break
            case .move:
                // TODO: Change the position of channels in the view.
                print("SBSMChannelCollection move")
                break
            case .clear:
                // TODO: Clear the view.
                print("SBSMChannelCollection clear")
                break
            case .none:
                print("SBSMChannelCollection none")
                break;
        @unknown default:
            print("action default")
        }
    }
}
