//
//  LoginView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/23.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    // MARK: - Propertiers
    @State private var userId = ""
    @State private var nickName = ""
      
    // MARK: - View
    var body: some View {
      VStack() {
        Image("logo_sb_sign")
            .resizable()
            .frame(width: 230, height: 300)
            .clipShape(Rectangle())
            //.overlay(Rectangle().stroke(Color.white, lineWidth: 4))
            //.shadow(radius: 10)
            //.padding(.bottom, 0)

        Text("Sol Eng Sample")
            .font(.title).foregroundColor(Color.purple)
            .multilineTextAlignment(.center)
            .padding([.top, .bottom], 40)

        TextField("User ID", text: self.$userId)
            .padding(.all, 10.0)
            .cornerRadius(20.0)

        TextField("Nickname", text: self.$nickName)
            .padding(.all, 10.0)
            .cornerRadius(20.0)

        Button("CONNECT")
        {
            SBManager.shared().connect(userId: self.userId) { (connected) in
                
            }
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .frame(width: 300, height: 50)
        .background(Color.purple)
        .cornerRadius(15.0)
        
      }.padding([.leading, .trailing], 27.5).modifier(AdaptsToKeyboard())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
