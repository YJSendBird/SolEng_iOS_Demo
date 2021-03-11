//
//  RoomListItemRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2021/03/11.
//  Copyright © 2021 YongjunChoi. All rights reserved.
//


import SwiftUI

struct RoomlListItemRow: View {
    
    var item:RoomlListModel
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    HStack(spacing: 10) {
                        AvatarView(url: item.coverUrl)
                        VStack(alignment: .leading, spacing: 3) {
                            // name
                            Text(item.name).font(.headline)
                            // post time
                            Text(item.roomId).font(.subheadline)
                        }
                    }
                }
                .padding(.leading, 10)  // spacing from left edge of the view
                .padding(.trailing, 10) // spacing from right edge of the view
            }
            .padding(.top, 5)
    }
}

struct RoomlListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        RoomlListItemRow(item: RoomlListModel(id: "0", name: "channel name", roomId: "", coverUrl:""))
    }
}
