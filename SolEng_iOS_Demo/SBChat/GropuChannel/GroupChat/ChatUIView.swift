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

    var channelUrl:String
    var isOpenChat:Bool
    var channelName:String
    var userId:String
    
    @State var typingMessage: String = ""
    @State var createdChannelUrl: String = ""

    @ObservedObject var models = SBManager.shared().chatModel

    init(isOpenChat:Bool, channelUrl:String, channelName:String) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        self.channelUrl = channelUrl
        self.isOpenChat = isOpenChat
        self.channelName = channelName
        self.userId = ""
    }

    init(isOpenChat:Bool, userId:String, name:String) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        self.channelUrl = ""
        self.isOpenChat = isOpenChat
        self.channelName = name
        self.userId = userId
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
        if isOpenChat {
            SBManager.shared().enterOpenChannels(channelUrl: channelUrl) { (result) in
                if result {
                    SBManager.shared().createMessageListQuery(isOpenChannel: self.isOpenChat, channelUrl: self.channelUrl) { (result) in
                        print(result)
                    }
                }
            }
        } else {
            if channelUrl.count > 0 {
                SBManager.shared().createMessageListQuery(isOpenChannel: isOpenChat, channelUrl: channelUrl) { (result) in
                    print(result)
                }
            } else {
                //채널 생성..
                SBManager.shared().createGroupChannel(userId: userId) { (result, groupChannelUrl) in
                    if result {
                        self.createdChannelUrl = groupChannelUrl!
                        SBManager.shared().createMessageListQuery(isOpenChannel: self.isOpenChat, channelUrl: groupChannelUrl!) { (result) in
                            print(result)
                        }
                    }
                }
            }

        }
    }
    
    private func delMessage() {
        SBManager.shared().chatModel.lists.removeAll()
    }

    private func sendMessage() {

        var url = channelUrl

        if self.createdChannelUrl.count > 0 {
            url = self.createdChannelUrl
        }

        SBManager.shared().sendMessage(isOpenChannel:isOpenChat, channelUrl: url, message:typingMessage ) { (result) in
            self.typingMessage = ""
            print(result)
        }
    }
}

struct ChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatUIView(isOpenChat:false, channelUrl:"", channelName: "test chat")
    }
}
