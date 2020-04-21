//
//  GroupChatListRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/27.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//


import SwiftUI

struct GroupChannelSyncListItemRow: View {
    
    var item:GroupChannelSyncModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    AvatarView(url: item.coverUrl)
                    VStack(alignment: .leading, spacing: 3) {
                        // name
                        Text(item.name).font(.headline)
                        // post time
                        Text(item.channelUrl).font(.subheadline)
                    }
                }
            }
            .padding(.leading, 10)  // spacing from left edge of the view
            .padding(.trailing, 10) // spacing from right edge of the view
        }
        .padding(.top, 5)
    }
}

struct GroupChannelSyncListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupChannelSyncListItemRow(item: GroupChannelSyncModel(id: "0", name: "channel name", channelUrl: "", coverUrl:""))
    }
}
