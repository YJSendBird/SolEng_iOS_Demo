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
        ChannelListItem(id: 0 , name: "Channel 01"),
        ChannelListItem(id: 1 , name: "Channel 02"),
        ChannelListItem(id: 2 , name: "Channel 03"),
        ChannelListItem(id: 3 , name: "Channel 04")
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
                    print("Add tapped!")
                }
        })
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelList()
    }
}
