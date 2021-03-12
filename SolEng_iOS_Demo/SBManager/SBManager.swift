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
import SendBirdDesk

class SBManager: NSObject, SBDConnectionDelegate, SBDUserEventDelegate, SBDChannelDelegate {
    
    // MARK: - Properties
    static let UNIQUE_DELEGATE_ID = "SBManager"
    
    //static let APP_ID = "9DA1B1F4-0BE6-4DA8-82C5-2E81DAB56F23"        //Sample
    //static let APP_ID = "A5192321-42DA-4ADC-8A75-6311D24BF4FE"      //SendBird-Calls-Playground
    static let APP_ID = "521FF53A-352D-4802-A285-F176C21BB825"      //My Sample - With Call YJAPP03
    //static let APP_ID = "EA2940C7-5696-4629-80B8-2E7CADF9FD0E"      //My Sample - With Call YJAPP01
    
    
    private var userListQuery:SBDApplicationUserListQuery?
    private var friendListQuery:SBDFriendListQuery?
    public var groupChannelSyncQuery:SBDGroupChannelListQuery?
    public var groupCollection: SBSMChannelCollection?
    //public var messageCollection: SBSMMessageCollection?
    private var groupChannelQuery:SBDGroupChannelListQuery?
    private var openChannelQuery:SBDOpenChannelListQuery?

    public var viewRouter = ViewRouter()

    public var gropuChannelSyncModel = GroupChannelSyncViewModel()
    public var groupChannelModel = GroupChannelViewModel()
    public var openChannelModel = OpenChannelViewModel()
    public var userModel = UserViewModel()
    public var chatModel = ChatViewModel()
    public var directCall: DirectCall?
    
    public var voiceModel = VoiceCallViewModel()
    public var videoModel = VideoCallViewModel()
    
    public var chatType = ChatUIView.ChatType.groupChat;

    private static var sharedManager: SBManager = {
        let shared = SBManager()
        //SBDMain.setLogLevel(.info)
        SBDMain.setLogLevel(SBDLogLevel.init(rawValue: 1112017) )
        SBDMain.initWithApplicationId(SBManager.APP_ID)  //CHAT
        SendBirdCall.configure(appId: SBManager.APP_ID)  //CALL
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
            //푸시 토큰 등록
            if UserDefaults.standard.pushTokenChange! {
                if UserDefaults.standard.pushToken != nil {
                    SBDMain.registerDevicePushToken(UserDefaults.standard.pushToken!, unique: false) { (status, error) in
                        if error == nil {
                            if status == SBDPushTokenRegistrationStatus.pending {
                                // A token registration is pending.
                                // If this status is returned, invoke `+ registerDevicePushToken:unique:completionHandler:` with `[SBDMain getPendingPushToken]` after connection.
                                completion(false)
                            }
                            else {
                                // A device token is successfully registered.
                                UserDefaults.standard.pushTokenChange = false
                            }
                        }
                        else {
                            // Registration failure.
                        }
                    }
                }
            }
            
            UserDefaults.standard.autoLogin = true
            UserDefaults.standard.user = (user!.userId, user!.nickname, nil)
            print("connect success")

            // after getting user's ID or login
            
            SBSMSyncManager.setup(withUserId: user!.userId)
            
            self.initViewModel()
            self.syncViewModel()
            self.viewRouter.currentPage = ViewRouter.PageEnum.mainView
            //Video Audio Server
            self.signIn(userId: userId) { (result) in
                if result {
                    print("authenticate success")
                    completion(true)
                }
            }

            //Desk Init
            // Initialize SendBIrd Desk
            SBDSKMain.initializeDesk()
            
        })
    }

    public func logOut() {
        UserDefaults.standard.user.id = ""
        self.viewRouter.currentPage = ViewRouter.PageEnum.loginView
    }

    private func initViewModel() {
        print("initViewModel")
        //사용자 목록 업데이트
        print("initUsersListQuery")
        initUsersQuery()
        
        print("initFriendsQuery")
        initFriendsQuery()

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
        
        print("getFriends")
        getFriends()
        
        print("getOpenChannels")
        getOpenChannels()
        
        print("getGroupChannels")
        getGroupChannels()
        
//        if messageCollection != nil {
//            self.loadNextSyncMessage(collection:self.messageCollection!) { (result) in
//                print(result)
//            }
//        }
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

            for user in users! {
                self.userModel.users.removeAll(where: { user.userId == $0.id})
                self.userModel.users.append(UserModel(id: user.userId, name: user.nickname!, avatar: user.profileUrl!))
            }

            if self.userListQuery?.hasNext == true {
                //반복해서 읽어오기
                self.getUsers()
            }
        })
    }
    
    public func initFriendsQuery() {
        if self.friendListQuery != nil {
            self.friendListQuery = nil
        }
        self.friendListQuery = SBDMain.createFriendListQuery()
    }
    
    public func getFriends() {
        friendListQuery?.loadNextPage(completionHandler: { (users, error) in
            guard error == nil else {   // Error.
                return
            }

            for user in users! {
                print(user.friendName!)
                print(user.friendDiscoveryKey!)
            }

            if self.friendListQuery?.hasNext == true {
                //반복해서 읽어오기
                self.getFriends()
            }
        })
    }


    public func deinitChannel() {
        print("deinitChannel")
        groupChannelSyncQuery = nil
        if(groupCollection != nil) {
            groupCollection!.remove()
            groupCollection!.delegate = nil
            groupCollection = nil
        }
    }
    
    public func deinitMessageCollection() {
//        if messageCollection != nil {
//            messageCollection!.remove()
//            messageCollection = nil
//        }
    }

    // MARK: - group chanel
    private func initGroupChannel(){
        self.groupChannelModel.lists.removeAll()
        if groupChannelQuery == nil {
            groupChannelQuery = SBDGroupChannel.createMyGroupChannelListQuery()!
            groupChannelQuery?.limit = 20
            groupChannelQuery?.includeEmptyChannel = true
            groupChannelQuery?.order = .chronological
            // SBDGroupChannelListOrderChronological, SBDGroupChannelListOrderLatestLastMessage, SBDGroupChannelListOrderChannelNameAlphabetical, and SBDGroupChannelListOrderChannelMetaDataValueAlphabetical

        }
    }
    
    private func getGroupChannels() {
        groupChannelQuery!.loadNextPage(completionHandler: { (groupChannels, error) in
                guard error == nil else {   // Error.
                    print(error.debugDescription)
                    return
                }
            
                for channel in groupChannels! {
                    self.groupChannelModel.lists.append(GroupChannelModel(id: channel.channelUrl, name: channel.name, channelUrl: channel.channelUrl, coverUrl: channel.coverUrl!))
                }
            
                if self.groupChannelQuery?.hasNext == true {
                    //반복해서 읽어오기
                    self.getGroupChannels()
                }
            })
    }

    func createGroupChannel(userId: String, completion: @escaping(Bool, String?) -> ()) {

        SBDGroupChannel.createChannel(withUserIds: [userId], isDistinct: true, completionHandler: { (groupChannel, error) in
            guard error == nil else {   // Error.
                completion(false, nil)
                return
            }
            completion(true, groupChannel?.channelUrl)
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
                    self.openChannelModel.lists.append(OpenChannelModel(id: channel.channelUrl, name: channel.name, channelUrl: channel.channelUrl, coverUrl: channel.coverUrl!))
                }

                if self.openChannelQuery?.hasNext == true {
                    //반복해서 읽어오기
                    self.getOpenChannels()
                }
            })
    }
    
    func enterOpenChannels(channelUrl: String, completion: @escaping(Bool) -> ()) {
        SBDOpenChannel.getWithUrl(channelUrl, completionHandler: { (openChannel, error) in
            guard error == nil else {   // Error.
                completion(false)
                return
            }
            openChannel?.enter(completionHandler: { (error) in
               guard error == nil else {   // Error.
                   completion(false)
                   return
               }
               completion(true)
            })
        })
    }
    
    // MARK: - Message list query
    func createMessageListQuery(isOpenChannel:Bool, channelUrl: String, completion: @escaping(Bool) -> ()) {
        print("createMessageListQuery =", channelUrl)
        
        if(isOpenChannel) {
            SBDOpenChannel.getWithUrl(channelUrl, completionHandler: { (openChannel, error) in
                guard error == nil else {   // Error.
                    return
                }
                // TODO: Implement what is needed with the contents of the response in the groupChannel parameter.
                // There should be only one single instance per channel.
                let previousMessageQuery = openChannel!.createPreviousMessageListQuery()
                previousMessageQuery?.includeMetaArray = true   // Retrieve a list of messages along with their metaarrays.
                previousMessageQuery?.includeReactions = true   // Retrieve a list of messages along with their reactions.

                self.chatModel.lists.removeAll()
                self.loadPreviousMessages(previousMessageQuery: previousMessageQuery!,  completion:completion)
            })
        } else {
            SBDGroupChannel.getWithUrl(channelUrl, completionHandler: { (groupChannel, error) in
                guard error == nil else {   // Error.
                    return
                }
                let previousMessageQuery = groupChannel!.createPreviousMessageListQuery()
                previousMessageQuery?.includeMetaArray = true   // Retrieve a list of messages along with their metaarrays.
                previousMessageQuery?.includeReactions = true   // Retrieve a list of messages along with their reactions.

                self.chatModel.lists.removeAll()
                self.loadPreviousMessages(previousMessageQuery: previousMessageQuery!,  completion:completion)
            })
        }

    }
    
    func loadPreviousMessages(previousMessageQuery: SBDPreviousMessageListQuery,  completion: @escaping(Bool) -> ()) {
        // Retrieving previous messages.
        previousMessageQuery.loadPreviousMessages(withLimit: 100, reverse: false, completionHandler: { (messages, error) in
            guard error == nil else {   // Error.
                return
            }

            if messages!.count == 0 {
                //더이상 읽은 것이 없다...
                completion(true)
            } else {
                for message in messages! {
                    self.chatModel.lists.append(SBManager.convertToChatModel(sbMessage: message))
                }
                self.loadPreviousMessages(previousMessageQuery: previousMessageQuery, completion:completion)
            }

        })
    }
    

    
    // MARK: - SendMessage
    func sendMessage(isOpenChannel:Bool, channelUrl: String, message:String, completion: @escaping(Bool) -> ()) {
        
        if(isOpenChannel) {
            SBDOpenChannel.getWithUrl(channelUrl, completionHandler: { (openChannel, error) in
                guard error == nil else {   // Error.
                    print(error.debugDescription)
                    return
                }
                
                let params = SBDUserMessageParams(message: message)
                //params.customType = CUSTOM_TYPE
                //params.data = DATA
                //params.mentionType = SBDMentionTypeUsers        // Either SBDMentionTypeUsers or SBDMentionTypeChannel
                params!.mentionedUserIds = ["Jeff", "Julia"]     // Or .mentionedUsers = LIST_OF_USERS_TO_MENTION
                //params!.metaArrayKeys = ["linkTo", "itemType"]
                params!.targetLanguages = ["fr", "de"]           // French and German
                params!.pushNotificationDeliveryOption = .default

                openChannel!.sendUserMessage(with: params!, completionHandler: { (userMessage, error) in
                    guard error == nil else {   // Error.
                        print(error.debugDescription)
                        return
                    }
                    
                   //UI 리스트에 추가...
                   self.chatModel.lists.append(SBManager.convertToChatModel(sbMessage: userMessage!))

                   completion(true)
                    
                })
                
            })
        } else {
            //일반채널의 경우
            SBDGroupChannel.getWithUrl(channelUrl, completionHandler: { (groupChannel, error) in
                guard error == nil else {   // Error.
                    print(error.debugDescription)
                    return
                }
                var userIDsToMention: [String] = []
                userIDsToMention.append("Harry")
                userIDsToMention.append("Jay")
                userIDsToMention.append("Jin")
                
                let params = SBDUserMessageParams(message: message)
                params?.mentionedUserIds = userIDsToMention

                guard let paramsBinded: SBDUserMessageParams = params else {
                    return
                }

                print(message)
                groupChannel!.sendUserMessage(with: paramsBinded, completionHandler: { (userMessage, error) in
                    guard error == nil else {
                        print(error.debugDescription)
                        completion(false)
                        return
                    }
                    
                    //UI 리스트에 추가...
                    //self.chatModel.lists.append(SBManager.convertToChatModel(sbMessage: userMessage!))

                    //syncmanager의 경우
                    //self.messageCollection?.appendMessage(userMessage!)
                    
                    completion(true)
                })
            })
            
        }
    }


    func sendFileMessage(isOpenChannel:Bool, channelUrl: String, fileData:Data, completion: @escaping(Bool) -> ()) {
        
        if(isOpenChannel) {
            SBDOpenChannel.getWithUrl(channelUrl, completionHandler: { (openChannel, error) in
                guard error == nil else {   // Error.
                    return
                }
            })
        } else {
            SBDGroupChannel.getWithUrl(channelUrl, completionHandler: { (groupChannel, error) in
                guard error == nil else {   // Error.
                    return
                }
                //
                var thumbnailSizes = [SBDThumbnailSize]()

                // Creating and adding a SBDThumbnailSize object (allowed number of thumbnail images: 3).
                thumbnailSizes.append(SBDThumbnailSize.make(withMaxCGSize: CGSize(width: 100.0, height: 100.0)))
                thumbnailSizes.append(SBDThumbnailSize.make(withMaxWidth: 200.0, maxHeight: 200.0))

                let params = SBDFileMessageParams(file: fileData)
                //params.fileName = FILE_NAME
                //params.fileSize = FILE_SIZE
                //params.mimeType = MIME_TYPE
                params!.thumbnailSizes = thumbnailSizes  // Set a SBDThumbnailSize object to a SBDFileMessageParams object.
                
                groupChannel!.sendFileMessage(with: params!, completionHandler: { (fileMessage, error) in
                    guard error == nil else {       // Error.
                        return
                    }

                    //let first = fileMessage?.thumbnails?[0]
                    //let second = fileMessage?.thumbnails?[1]

                    //let maxSizeFirst = first?.maxSize       // 100
                    //let maxSizeSecond = second?.maxSize     // 200

                    //let urlFirst = first?.url
                    //let urlSecond = second?.url
                })
                //
            })
        }
    }
    
    func printLog(log: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
        print(formatter.string(from: NSDate() as Date), terminator: "")
        if log == nil {
            print("nil")
        }
        else {
            print(log)
        }
    }
    
    // MARK: - SBDConnectionDelegate
    func didStartReconnection() {
        print("SBDConnectionDelegate didStartReconnection")
        print("SBDConnectionDelegate pauseSynchronize")
        SBSMSyncManager.pauseSynchronize()
    }

    func didSucceedReconnection() {
        print("SBDConnectionDelegate didSucceedReconnection")
        print("SBDConnectionDelegate resumeSynchronize")
        SBSMSyncManager.resumeSynchronize()
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
        print("SBDChannelDelegate didReceive::message")

        //UI 리스트에 추가
        //TODO - SyncManager chat이면 여기서 메시지 수신처리를 하면 안됨
        UserNotiRegister.shared().registUserNoti(sbMessage: message)
        if chatType != ChatUIView.ChatType.groupChatSync {
            DispatchQueue.main.async {
                self.chatModel.lists.append(SBManager.convertToChatModel(sbMessage: message))
            }
        }
    }

    func channel(_ sender: SBDBaseChannel, didUpdate message: SBDBaseMessage) {
        print("SBDChannelDelegate didUpdate")
    }

    func channel(_ sender: SBDBaseChannel, messageWasDeleted messageId: Int64) {
        print("SBDChannelDelegate messageWasDeleted")
    }

    func channel(_ channel: SBDBaseChannel, didReceiveMention message: SBDBaseMessage) {
        print("SBDChannelDelegate didReceiveMention")
    }

    func channelWasChanged(_ sender: SBDBaseChannel) {
        print("SBDChannelDelegate channelWasChanged")
        if sender is SBDGroupChannel {
            //TODO 이미 있으면 지우고 업데이트
            let model = GroupChannelModel(id: sender.channelUrl, name: sender.name, channelUrl: sender.channelUrl, coverUrl: sender.coverUrl!)
            self.groupChannelModel.lists.removeAll(where: { model.channelUrl == $0.channelUrl})
            self.groupChannelModel.lists.append(model)
        } else {
            //이미 있으면 지우고 업데이트
            let model = OpenChannelModel(id: sender.channelUrl, name: sender.name, channelUrl: sender.channelUrl, coverUrl: sender.coverUrl!)
            self.openChannelModel.lists.removeAll(where: { model.channelUrl == $0.channelUrl})
            self.openChannelModel.lists.append(model)
        }
    }

    func channelWasDeleted(_ channelUrl: String, channelType: SBDChannelType) {
        print("SBDChannelDelegate channelWasDeleted")
    }

    func channelWasFrozen(_ sender: SBDBaseChannel) {
        print("SBDChannelDelegate channelWasFrozen")
    }

    func channelWasUnfrozen(_ sender: SBDBaseChannel) {
        print("SBDChannelDelegate channelWasUnfrozen")
    }

    func channel(_ sender: SBDBaseChannel, createdMetaData: [String : String]?) {
        print("SBDChannelDelegate createdMetaData")
    }

    func channel(_ sender: SBDBaseChannel, updatedMetaData: [String : String]?) {
        print("SBDChannelDelegate updatedMetaData")
    }

    func channel(_ sender: SBDBaseChannel, deletedMetaDataKeys: [String]?) {
        print("SBDChannelDelegate deletedMetaDataKeys")
    }

    func channel(_ sender: SBDBaseChannel, createdMetaCounters: [String : NSNumber]?) {
        print("SBDChannelDelegate createdMetaCounters")
    }

    func channel(_ sender: SBDBaseChannel, updatedMetaCounters: [String : NSNumber]?) {
        print("SBDChannelDelegate updatedMetaCounters")
    }

    func channel(_ sender: SBDBaseChannel, deletedMetaCountersKeys: [String]?) {
        print("SBDChannelDelegate deletedMetaCountersKeys")
    }

    func channelWasHidden(_ sender: SBDGroupChannel) {
        print("SBDChannelDelegate channelWasHidden")
    }

    func channel(_ sender: SBDGroupChannel, didReceiveInvitation invitees: [SBDUser]?, inviter: SBDUser?) {
        print("SBDChannelDelegate didReceiveInvitation")
    }

    func channel(_ sender: SBDGroupChannel, didDeclineInvitation invitee: SBDUser, inviter: SBDUser?) {
        print("SBDChannelDelegate didDeclineInvitation")
    }

    func channel(_ sender: SBDGroupChannel, userDidJoin user: SBDUser) {
        print("SBDChannelDelegate userDidJoin")
    }

    func channel(_ sender: SBDGroupChannel, userDidLeave user: SBDUser) {
        print("SBDChannelDelegate userDidLeave")
    }

    func channelDidUpdateReadReceipt(_ sender: SBDGroupChannel) {
        print("SBDChannelDelegate channelDidUpdateReadReceipt")
    }

    func channelDidUpdateTypingStatus(_ sender: SBDGroupChannel) {
        print("SBDChannelDelegate channelDidUpdateTypingStatus")
    }

    func channel(_ sender: SBDOpenChannel, userDidEnter user: SBDUser) {
        print("SBDChannelDelegate userDidEnter")
    }

    func channel(_ sender: SBDOpenChannel, userDidExit user: SBDUser) {
        print("SBDChannelDelegate userDidExit")
    }

    func channel(_ sender: SBDBaseChannel, userWasMuted user: SBDUser) {
        print("SBDChannelDelegate userWasMuted")
    }

    func channel(_ sender: SBDBaseChannel, userWasUnmuted user: SBDUser) {
        print("SBDChannelDelegate userWasUnmuted")
    }

    func channel(_ sender: SBDBaseChannel, userWasBanned user: SBDUser) {
        print("SBDChannelDelegate userWasBanned")
    }

    func channel(_ sender: SBDBaseChannel, userWasUnbanned user: SBDUser) {
        print("SBDChannelDelegate userWasUnbanned")
    }
    
    // MARK: - SBDUserEventDelegate
    func didDiscoverFriends(_ friends: [SBDUser]?) {
        print("SBDUserEventDelegate didDiscoverFriends")
    }

    func didUpdateTotalUnreadMessageCount(_ totalCount: Int32, totalCountByCustomType: [String : NSNumber]?) {
        print("SBDUserEventDelegate didUpdateTotalUnreadMessageCount")
    }
}
