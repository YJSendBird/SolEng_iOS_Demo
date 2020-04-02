//
//  UserUIView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/01.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct UserUIView: View {
    
    @State var models = UserViewModel()
    
    var body: some View {
        List(models.users) { user in
            //NavigationLink(destination: ChatUIView()) {
                UserListItemRow(user : user)
            //}
        }
        .navigationBarTitle(Text("Users"))
//        .navigationBarItems(trailing:
//            HStack {
//                Button("Add") {
//                    print("Add tapped!")
//                }
//        })
    }
}

struct UserUIView_Previews: PreviewProvider {
    static var previews: some View {
        UserUIView()
    }
}
