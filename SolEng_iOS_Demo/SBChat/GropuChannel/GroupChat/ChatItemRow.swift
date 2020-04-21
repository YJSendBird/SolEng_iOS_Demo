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
            if item.messageType ==  MessageType.adminMessage {
                AdminMessageView(contentMessage: item.message)
            } else {
                if !item.user.isCurrentUser {
                    AvatarView(url: item.user.avatar)
                    ReceiveMessageView(contentMessage: item.message)
                    Spacer()
                }else {
                    Spacer()
                    SendMessageView(contentMessage: item.message)
                }
            }

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
