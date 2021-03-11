//
//  WebChat.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/05/14.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct WebChat: View {
    
    @ObservedObject var model = WebViewModel(link: "http://127.0.0.1:9000/")
    
    var body: some View {
        VStack(){
            Text(model.link)
            SwiftUIWebView(viewModel: model)
    //             if model.didFinishLoading {
    //                 //do your stuff
    //             }
        }
    }
}

struct WebChat_Previews: PreviewProvider {
    static var previews: some View {
        WebChat()
    }
}
