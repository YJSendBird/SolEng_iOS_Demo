//
//  RoomList.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2021/03/11.
//  Copyright © 2021 YongjunChoi. All rights reserved.
//

import SwiftUI

struct RoomList: View {
    
    @ObservedObject var models = RoomListViewModel()

    var body: some View {
        List(models.lists) { item in
            NavigationLink(destination: VideoCallUIView()) {
                RoomlListItemRow(item : item)
            }
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

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList()
    }
}
