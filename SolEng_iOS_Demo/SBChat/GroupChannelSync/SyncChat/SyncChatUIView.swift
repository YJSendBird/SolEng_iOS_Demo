//
//  SyncChatUIView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2021/02/22.
//  Copyright © 2021 YongjunChoi. All rights reserved.
//

import SwiftUI
import SendBirdSyncManager
import SendBirdSDK

struct SyncChatUIView: View{

    var channelName:String
    var userId:String
    let channel02 = "sendbird_group_channel_297611217_4632682778ec8ba6e4d3333164d7c231ff8c0ad6"
    
    @State var newChatOn = false
    @State var typingMessage: String = ""
    @State var createdChannelUrl: String = ""
    @ObservedObject var models : SyncChatViewModel

    init(channelName:String, viewModel: SyncChatViewModel) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        self.channelName = channelName
        self.userId = ""
        _models = ObservedObject(wrappedValue: viewModel)
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
            NavigationLink(destination: SyncChatUIView(channelName: "new channel",viewModel: SyncChatViewModel(channelUrl: channel02)), isActive: self.$newChatOn) {
                EmptyView()
            }.frame(width: 0, height: 0)
            .navigationBarItems(trailing:
                HStack {
                    Button("New Chat") {
                        self.newChatOn = true
                    }
            })
        }
        //.onAppear(perform: fetchMessage)
        //.onDisappear(perform: release)
        .navigationBarTitle(Text(self.channelName))
    }

    func sendMessage() {
        models.sendMessage(message:typingMessage)
    }

    func fetchMessage(){
        models.fetchMessage()
    }

}

struct SyncChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel =  SyncChatViewModel(channelUrl: "")
        SyncChatUIView(channelName:"", viewModel: viewModel)
    }
}
