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
    
    var body: some View {
        HStack(alignment: .center) {
            Text("ID:" + user.id)
                .padding(.leading, 40.0)
            Text("Name:" + user.name)
            Spacer()
        }
    }
}

struct UserListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        UserListItemRow(user: UserModel(id:"아이디는",name:  "name"))
    }
}
