//
//  OpenChannelList.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/07.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct OpenChannelList: View {
    
    @State var models = SBManager.shared().openChannelModel

    var body: some View {
        List(models.lists) { item in
            //NavigationLink(destination: ChatUIView(channelUrl: item.channelUrl)) {
               OpenChannelListItemRow(item : item)
            //}
        }
        .navigationBarTitle(Text("Open Channel List"))
        .navigationBarItems(trailing:
            HStack {
                Button("Add") {
                    print("Add tapped!")
                }
        })
    }
}

struct OpenChannelList_Previews: PreviewProvider {
    static var previews: some View {
        OpenChannelList()
    }
}
