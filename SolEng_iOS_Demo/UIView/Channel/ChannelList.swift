//
//  MenuDetailView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/24.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct ChannelList: View {
    
    var channelItems = [
        ChannelListItem(id: 0 , name: "Group Channel"),
        ChannelListItem(id: 1 , name: "Open Channel"),
        ChannelListItem(id: 2 , name: "Broadcast Channel"),
        ChannelListItem(id: 3 , name: "SendBird Call")
    ]
    
    var body: some View {
        List(channelItems) { item in
            NavigationLink(destination: ChatUIView()) {
                ChannelListItemRow(item : item)
            }
        }
        .navigationBarTitle(Text("Channel List"))
        .navigationBarItems(trailing:
            HStack {
                Button("Add") {
                    print("About tapped!")
                    GlobalValues.sharedInstance.userId = ""
                }
        })
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelList()
    }
}
