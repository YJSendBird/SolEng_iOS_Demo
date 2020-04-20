//
//  VideoCallViewController.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//
import SwiftUI

struct VideoCallUIView: View {
    
    @State var models = VideoCallViewModel()
    
    var body: some View {
        HStack(alignment: .center) {
            Text("")
        }.navigationBarTitle(Text("VideoCall"))
    }
}

struct VideoCallUIView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCallUIView()
    }
}
