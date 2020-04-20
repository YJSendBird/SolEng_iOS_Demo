//
//  GroupChannelListItemRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/09.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct GroupChannelListItemRow: View {
    
    var item:GroupChannelModel
    
    var body: some View {
            HStack(alignment: .center) {
                Text("ID:" + item.id)
                .padding(.leading, 40.0)
                Text("Name:" + item.name)
            Spacer()
        }
    }
}

struct GroupChannelListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupChannelListItemRow(item: GroupChannelModel(id: "0", name: "channel name", channelUrl: ""))
    }
}
