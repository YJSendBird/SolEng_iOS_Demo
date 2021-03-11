//
//  ChatUIView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/31.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI
import SendBirdSDK

struct ChatUIView: View {

    enum ChatType:String {
         case groupChat = "groupChat"
         case openChat = "openChat"
         case groupChatSync = "groupChatSync"
    }
    
    var channelUrl:String
    var chatType:ChatType
    var channelName:String
    var userId:String
    
    @State var typingMessage: String = ""
    @State var createdChannelUrl: String = ""

    @ObservedObject var models = SBManager.shared().chatModel

    init(chatType:ChatType, channelUrl:String, channelName:String) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        self.channelUrl = channelUrl//channelUrl
        self.chatType = chatType
        self.channelName = channelName
        self.userId = ""
        SBManager.shared().chatType = chatType
    }

    init(chatType:ChatType, userId:String, name:String) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        self.channelUrl = ""
        self.chatType = chatType
        self.channelName = name
        self.userId = userId
        SBManager.shared().chatType = chatType
    }
    
    var body: some View {
        VStack {
            CustomScrollView(scrollToEnd: true) {
                ForEach(self.models.lists, id: \.self) { item in
                    ChatItemRow(item : item)
                }.padding(5)
            }
            HStack {
               TextField("Message...", text: $typingMessage)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .frame(minHeight: CGFloat(30))
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
        }
        .onAppear(perform: getMessage)
        .onDisappear(perform: delMessage)
        .navigationBarTitle(Text(self.channelName))
    }
    
    private func getMessage() {
        //open channel 인경우 가입...
        switch self.chatType {
        case ChatType.openChat:
            SBManager.shared().enterOpenChannels(channelUrl: self.channelUrl) { (result) in
                if result {
                    SBManager.shared().createMessageListQuery(isOpenChannel: true, channelUrl: self.channelUrl) { (result) in
                        print(result)
                    }
                }
            }
            break
        case ChatType.groupChat:
            if self.channelUrl.count > 0 {
                SBManager.shared().createMessageListQuery(isOpenChannel: false, channelUrl: channelUrl) { (result) in
                    print(result)
                }
            } else {
                //채널 생성..
                SBManager.shared().createGroupChannel(userId: self.userId) { (result, groupChannelUrl) in
                    if result {
                        self.createdChannelUrl = groupChannelUrl!
                        SBManager.shared().createMessageListQuery(isOpenChannel: false, channelUrl: groupChannelUrl!) { (result) in
                            print(result)
                        }
                    }
                }
            }
            break
        case ChatType.groupChatSync:
//            SBManager.shared().initSyncMessageCollection(channelUrl:channelUrl) { (result) in
//                print(result)
//            }
            break
        }

        /*
        if self.chatType == ChatType.openChat {
            SBManager.shared().enterOpenChannels(channelUrl: channelUrl) { (result) in
                if result {
                    SBManager.shared().createMessageListQuery(isOpenChannel: true, channelUrl: self.channelUrl) { (result) in
                        print(result)
                    }
                }
            }
        } self.chatType == ChatType.groupChat {
            if channelUrl.count > 0 {
                SBManager.shared().createMessageListQuery(isOpenChannel: isOpenChat, channelUrl: channelUrl) { (result) in
                    print(result)
                }
            } else {
                //채널 생성..
                SBManager.shared().createGroupChannel(userId: userId) { (result, groupChannelUrl) in
                    if result {
                        self.createdChannelUrl = groupChannelUrl!
                        SBManager.shared().createMessageListQuery(isOpenChannel: false, channelUrl: groupChannelUrl!) { (result) in
                            print(result)
                        }
                    }
                }
            }

        }
        */
    }
    
    private func delMessage() {
        SBManager.shared().deinitMessageCollection()
        SBManager.shared().chatModel.lists.removeAll()
    }

    private func sendMessage() {

        var url = channelUrl

        if self.createdChannelUrl.count > 0 {
            url = self.createdChannelUrl
        }

        var isOpenChat = false

        switch self.chatType {
            case ChatType.openChat: isOpenChat = true
        case .groupChat:
            isOpenChat = false
        case .groupChatSync:
            isOpenChat = false
        }

        /*
        for n in 1...20 {
            
            let aStr = String(format: "%@%x", typingMessage, n)
            
            SBManager.shared().sendMessage(isOpenChannel:isOpenChat, channelUrl: url, message:aStr ) { (result) in
                //self.typingMessage = ""
                print(result)
            }
        }
        */

        SBManager.shared().sendMessage(isOpenChannel:isOpenChat, channelUrl: url, message:typingMessage) { (result) in
            self.typingMessage = ""
            print(result)
        }

    }
}

struct ChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatUIView(chatType:ChatUIView.ChatType.openChat, channelUrl:"", channelName: "test chat")
    }
}
