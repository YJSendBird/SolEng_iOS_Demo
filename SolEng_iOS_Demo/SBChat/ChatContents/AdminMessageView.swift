//
//  AdminMessageView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/21.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct AdminMessageView: View {
    var contentMessage: String
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(Color.black)
            .background(Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}

struct AdminMessageView_Previews: PreviewProvider {
    static var previews: some View {
        AdminMessageView(contentMessage: "Hi, I am your friend")
    }
}
