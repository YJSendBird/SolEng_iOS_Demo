//
//  UserListItemRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/01.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct UserListItemRow: View {
    var user:UserModel
    let size: CGFloat = 40

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
                    
                    Spacer()
                    
                    Image("icLogoInverse01") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: size, height: size)
                        .onTapGesture { print("Chat button pressed") }
                    
                    Image("btnCallVoice") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: size, height: size)
                        .onTapGesture {
                            print("Voice button pressed")
                        }
                    
                    Image("btnCallVideo") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: size, height: size)
                        .onTapGesture { print("Video button pressed") }
                    
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
