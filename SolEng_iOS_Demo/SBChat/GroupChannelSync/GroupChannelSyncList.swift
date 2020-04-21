//
//  MenuDetailView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/24.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct GroupChannelSyncList: View {
    
    @ObservedObject var models = SBManager.shared().gropuChannelSyncModel

    var body: some View {
        List(models.lists) { item in
            NavigationLink(destination: ChatUIView(isOpenChat:false, channelUrl: item.channelUrl, channelName: item.name)) {
                GroupChannelSyncListItemRow(item : item)
            }
        }
        .navigationBarTitle(Text("Group Channel Sync List"))
        .navigationBarItems(trailing:
            HStack {
                Button("Add") {
                    print("Add tapped!")
                }
        })
    }
}

struct GroupChannelSyncList_Previews: PreviewProvider {
    static var previews: some View {
        GroupChannelSyncList()
    }
}
