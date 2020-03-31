//
//  GroupChatListRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/27.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//


import SwiftUI

struct ChannelListItemRow: View {
    
    var item:ChannelListItem
    
    var body: some View {
        Text(item.name)
    }
}

struct GroupChatListRow_Previews: PreviewProvider {
    static var previews: some View {
        ChannelListItemRow(item: ChannelListItem(id: 0, name: "channel name"))
    }
}
