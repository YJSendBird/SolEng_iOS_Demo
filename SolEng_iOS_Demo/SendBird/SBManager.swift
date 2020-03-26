//
//  SBManager.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/25.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SendBirdSyncManager

class SBManager: NSObject, SBDConnectionDelegate, SBDUserEventDelegate, SBDChannelDelegate {
    // MARK: - Properties

    static let UNIQUE_DELEGATE_ID = "SBManager"
    
    static let APP_ID = "9DA1B1F4-0BE6-4DA8-82C5-2E81DAB56F23"

    private static var sharedManager: SBManager = {
        let shared = SBManager()
        SBDMain.initWithApplicationId(SBManager.APP_ID)
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

    public func connect(userId: String) {
        SBDMain.connect(withUserId: userId, completionHandler: { (user, error) in
            guard error == nil else {   // Error.
                print(error.debugDescription)
                return
            }
            print("SBManager coneected")
            GlobalValues.sharedInstance.userId = userId
        })
    }
    
    // MARK: - SBDConnectionDelegate
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

    func channel(_ sender: SBDGroupChannel, didDeclineInvitation invitee: SBDUser?, inviter: SBDUser?) {
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
    
    // MARK: - SBDChannelDelegate
    func didStartReconnection() {
        print("SBDConnectionDelegate didStartReconnection")
    }

    func didSucceedReconnection() {
        print("SBDConnectionDelegate didSucceedReconnection")
    }

    func didFailReconnection() {
        print("SBDConnectionDelegate didFailReconnection")
    }
    
    func didCancelReconnection() {
        print("SBDConnectionDelegate didCancelReconnection")
    }
}
