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
    
    @State var typingMessage: String = ""

    @ObservedObject var models = SBManager.shared().chatModel

    init(channelUrl:String) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        self.channelUrl = channelUrl
    }
    
    var body: some View {
        VStack {
            List(models.lists) { item in
                ChatItemRow(item : item)
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
        .navigationBarTitle(Text("Message List"))
    }
    
    private func getMessage() {
        SBManager.shared().createMessageListQuery(isOpenChannel: false, channelUrl: channelUrl) { (result) in
            print(result)
        }
    }

    private func sendMessage() {
        SBManager.shared().sendMessage(isOpenChannel:false, channelUrl: channelUrl, message:typingMessage ) { (result) in
            self.typingMessage = ""
            print(result)
        }
    }
}

struct ChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatUIView(channelUrl:"")
    }
}
