//
//  OpenChannelListItemRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/07.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct OpenChannelListItemRow: View {
    
    var item:OpenChannelModel
    
    var body: some View {
            HStack(alignment: .center) {
                Text("ID:" + item.id)
                .padding(.leading, 40.0)
                Text("Name:" + item.name)
            Spacer()
        }
    }
}

struct OpenChannelListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        OpenChannelListItemRow(item: OpenChannelModel(id: "0", name: "channel name", channelUrl: ""))
    }
}
