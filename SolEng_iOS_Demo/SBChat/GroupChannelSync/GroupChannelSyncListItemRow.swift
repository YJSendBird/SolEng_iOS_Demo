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
            HStack(alignment: .center) {
                Text("ID:" + item.id)
                .padding(.leading, 40.0)
                Text("Name:" + item.name)
            Spacer()
        }
    }
}

struct GroupChannelSyncListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupChannelSyncListItemRow(item: GroupChannelSyncModel(id: "0", name: "channel name", channelUrl: ""))
    }
}
