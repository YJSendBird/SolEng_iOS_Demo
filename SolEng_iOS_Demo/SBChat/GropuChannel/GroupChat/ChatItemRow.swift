//
//  ChatItemRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/17.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct ChatItemRow: View {
    
    var item:ChatModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if !item.user.isCurrentUser {
                Image(item.user.avatar)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            } else {
                Spacer()
            }
            ContentMessageView(contentMessage: item.message,
                               isCurrentUser: item.user.isCurrentUser)
        }.onAppear(perform: checkItem)

    }
    
    private func checkItem() {
        print(item.message)
    }
}

struct ChatItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatItemRow(item: ChatModel())
    }
}
