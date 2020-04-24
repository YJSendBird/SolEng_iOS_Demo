//
//  VoiceCallViewController.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//


import SwiftUI

struct VoiceCallUIView: View {
    
    @State var models = VoiceCallViewModel()
    
    var body: some View {
        HStack(alignment: .center) {
            Text("")
        }.navigationBarTitle(Text("VoiceCall"))
    }
}

//struct VoiceCallUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        VoiceCallUIView(models: VoiceCallViewModel())
//    }
//}
