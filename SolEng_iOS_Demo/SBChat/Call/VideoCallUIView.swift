//
//  VideoCallViewController.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//
import SwiftUI

struct VideoCallUIView: View {
    
    let size: CGFloat = 35
    
    @State var viewModel = VideoCallViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
                   Text(viewModel.model.userId)
                   Text("callTimer")

                   HStack(alignment: .center) {

                       Image("btnSpeaker") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                           .resizable()
                           .frame(width: size, height: size)
                           .onTapGesture {
                               
                           }

                       Image("btnAudioOff") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                           .resizable()
                           .frame(width: size, height: size)
                           .onTapGesture {
                               
                           }
                       
                       Image("btnCallEnd") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                           .resizable()
                           .frame(width: size, height: size)
                           .onTapGesture {
                               
                           }
                   }

               }.navigationBarTitle(Text("VoiceCall"))
    }
}

struct VideoCallUIView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCallUIView()
    }
}
