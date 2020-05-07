//
//  VoiceCallViewController.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//


import SwiftUI
import NotificationCenter

struct VoiceCallUIView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let size: CGFloat = 50
    
    @ObservedObject var viewModel = SBManager.shared().voiceModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(viewModel.model.userId)
            Text(viewModel.model.timer)
            HStack(alignment: .center) {
                if (!viewModel.model.isSpeakerEnable) {
                    Image("btnSpeaker") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: size, height: size)
                        .onTapGesture {
                            print("btnSpeaker pressed")
                            self.viewModel.model.isSpeakerEnable = true
                        }
                } else {
                    Image("btnSpeakerSelected") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: size, height: size)
                        .onTapGesture {
                            print("btnSpeaker pressed")
                            self.viewModel.model.isSpeakerEnable = false
                        }
                }

                if (!viewModel.model.isAudioEnable) {
                    Image("btnAudioOff") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    .resizable()
                    .frame(width: size, height: size)
                    .onTapGesture {
                        print("btnAudioOff pressed")
                        self.viewModel.model.isAudioEnable = true
                        SBManager.shared().updateLocalAudio(SBManager.shared().directCall!, isEnabled: true)
                    }
                } else {
                    Image("btnAudioOffSelected") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    .resizable()
                    .frame(width: size, height: size)
                    .onTapGesture {
                        print("btnAudioOffSelected pressed")
                        self.viewModel.model.isAudioEnable = false
                        SBManager.shared().updateLocalAudio(SBManager.shared().directCall!, isEnabled: false)
                    }
                }

                Image("btnCallEnd") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    .resizable()
                    .frame(width: size, height: size)
                    .onTapGesture {
                        print("btnCallEnd pressed")
                        SBManager.shared().callEnd(SBManager.shared().directCall!)
                        //이전화면으로 이동
                        self.viewModel.model.isCalling = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .navigationBarTitle(Text("VoiceCall"))
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.CallEnd)){ obj in
            if let userInfo = obj.userInfo, let info = userInfo["info"] {
              print(info)
              self.viewModel.model.isCalling = false
              self.presentationMode.wrappedValue.dismiss()
           }
        }
    }
}

struct VoiceCallUIView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceCallUIView()
    }
}
