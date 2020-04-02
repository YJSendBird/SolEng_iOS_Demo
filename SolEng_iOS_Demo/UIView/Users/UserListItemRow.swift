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
        Text(user.name)
    }
}

struct UserListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        UserListItemRow(user: UserModel(id:"",name:""))
    }
}
