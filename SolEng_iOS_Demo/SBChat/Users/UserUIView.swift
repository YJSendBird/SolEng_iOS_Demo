//
//  UserUIView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/01.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct UserUIView: View {
    
    @ObservedObject var models = SBManager.shared().userModel

    var body: some View {

            List(models.users) { user in
                //NavigationLink(destination: ChatUIView(isOpenChat:false, userId: user.id, name: user.name)) {
                    UserListItemRow(user : user)
                //}
            }
            .navigationBarTitle(Text("Users"))
    }
}

struct UserUIView_Previews: PreviewProvider {
    static var previews: some View {
        UserUIView()
    }
}
