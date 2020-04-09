//
//  GroupChannelList.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/09.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//


import SwiftUI

struct GroupChanneljList: View {
    
    @State var models = SBManager.shared().groupChannelModel

    var body: some View {
        List(models.lists) { item in
            NavigationLink(destination: ChatUIView()) {
                GroupChannelListItemRow(item : item)
            }
        }
        .navigationBarTitle(Text("Group Channel List"))
        .navigationBarItems(trailing:
            HStack {
                Button("Add") {
                    print("Add tapped!")
                }
        })
    }
}

struct GroupChannelList_Previews: PreviewProvider {
    static var previews: some View {
        GroupChanneljList()
    }
}
