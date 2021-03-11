//
//  DeskChannelList.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/08/25.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI
import SendBirdSDK

struct DeskChannelList: View {
    @State var channelUrl = ""
    @State var channelName = ""
    @State var deskOn = false

    var body: some View {
        NavigationLink(destination: ChatUIView(chatType:ChatUIView.ChatType.groupChatSync, channelUrl: self.channelUrl, channelName: self.channelName), isActive: self.$deskOn) {
            EmptyView()
        }
        .navigationBarTitle(Text("Desk Channel"))
        .navigationBarItems(trailing:
            HStack {
                Button("Add") {
                    self.doDesk()
                }
            })
        }
        func doDesk() {
            SBManager.shared().connectDesk(userId: SBDMain.getCurrentUser()!.userId, accessToken: "") { (connect) in
                if connect {
                    SBManager.shared().createTicket(title: "상담요청", userName: SBDMain.getCurrentUser()!.userId) { (groupChannel) in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                          self.channelUrl = groupChannel!.channelUrl
                          self.channelName = groupChannel!.name
                            print("channelName ::",self.channelName)
                            print("channelUrl ::",self.channelUrl)
                          self.deskOn = true
                        }
                    }
                }
            }
        }
    }

struct DeskChannelList_Previews: PreviewProvider {
    static var previews: some View {
        DeskChannelList()
    }
}
