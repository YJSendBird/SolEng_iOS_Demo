//
//  RootUIView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/23.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI
    
struct RootUIView: View {
    
    @State var userId = GlobalValues.sharedInstance.userId
    
    init() {
        if userId.count > 0 {
            SBManager.shared().connect(userId: self.userId)
        }
    }

    var body: some View {
        Group {
            userId.count > 0 ? AnyView(MainView()) : AnyView(LoginView())
        }.onReceive(GlobalValues.sharedInstance.userIdString) {
            self.userId = $0
        }
    }
}

struct RootUIView_Previews: PreviewProvider {
    static var previews: some View {
        RootUIView()
    }
}
