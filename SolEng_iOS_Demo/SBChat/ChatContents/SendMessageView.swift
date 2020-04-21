//
//  ContentMessageView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/20.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct SendMessageView: View {
    var contentMessage: String
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SendMessageView(contentMessage: "Hi, I am your friend")
    }
}
