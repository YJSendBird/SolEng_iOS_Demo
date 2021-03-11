//
//  UserListItemRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/01.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI
import Combine

struct UserListItemRow: View {

    var user:UserModel
    let size: CGFloat = 35
    @State var chatOn = false
    @State var voiceOn = false
    @State var videoOn = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    AvatarView(url: user.avatar)
                    VStack(alignment: .leading, spacing: 3) {
                        // name
                        Text(user.name).font(.headline)
                        // post time
                        Text(user.id).font(.subheadline)
                    }
                }
                HStack(spacing: 10) {
                    Spacer()
                    NavigationLink(destination: ChatUIView(chatType:ChatUIView.ChatType.groupChat, userId: user.id, name: user.name), isActive: $chatOn) {
                        EmptyView()
                    }.frame(width: 0, height: 0)
                    NavigationLink(destination: VoiceCallUIView(), isActive: $voiceOn) {
                        EmptyView()
                    }.frame(width: 0, height: 0)
                    NavigationLink(destination: VideoCallUIView(), isActive: $videoOn) {
                        EmptyView()
                    }.frame(width: 0, height: 0)

                    Image("icLogoInverse01") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: size, height: size)
                        .onTapGesture {
                            self.chatOn = true
                    }
                    Image("btnCallVoice") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: size, height: size)
                        .onTapGesture {
                            SBManager.shared().doVoiceCall(calleeId: self.user.id) { (result, call) in
                                if result {
                                    DispatchQueue.main.async {
                                        self.voiceOn = true
                                        SBManager.shared().voiceModel.model.isCalling = true
                                        SBManager.shared().voiceModel.model.userId = self.user.id
                                    }
                                }
                            }
                    }
                    Image("btnCallVideo") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: size, height: size)
                        .onTapGesture {
                            SBManager.shared().doVideoCall(calleeId: self.user.id) { (result, call) in
                                if result {
                                    DispatchQueue.main.async {
                                        self.videoOn = true
                                        SBManager.shared().videoModel.model.isCalling = true
                                        SBManager.shared().videoModel.model.userId = self.user.id
                                    }

                                }
                            }
                            
                    }
                }
            }
            .padding(.leading, 10)  // spacing from left edge of the view
            .padding(.trailing, 10) // spacing from right edge of the view
        }
        .padding(.top, 5)
    }
}

struct UserListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        UserListItemRow(user: UserModel(id:"userid",name:  "username"))
    }
}
