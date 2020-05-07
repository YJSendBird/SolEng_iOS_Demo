//
//  VideoCallViewController.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//
import SwiftUI
import SendBirdCalls

struct VideoCallUIView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let size: CGFloat = 50
    
    @State var maxHeight:CGFloat = 200
    
    @ObservedObject var viewModel = SBManager.shared().videoModel

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
                    Text(viewModel.model.userId)
                    Text(viewModel.model.timer)
            
                    ZStack {
                        VStack(alignment: .leading) {
                            VideoView(isLocal: true, call: SBManager.shared().directCall!)
                               .cornerRadius(15)
                                .frame(width: 100, height: 150, alignment: .topLeading)
                               .shadow(color: Color.white.opacity(1.0), radius: 30, x: 0, y: 2)
                               .padding(.horizontal, 10)
                               .padding(.top, 20)
                            VideoView(isLocal: false, call: SBManager.shared().directCall!)
                                .cornerRadius(15)
                                .frame(width: nil, height: 400, alignment: .center)
                                .shadow(color: Color.black.opacity(0.7), radius: 30, x: 0, y: 2)
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                        }
                    }


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
                    
                        if (!viewModel.model.isVideoEnable) {
                            Image("btnVideoOff") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .resizable()
                                .frame(width: size, height: size)
                                .onTapGesture {
                                    self.viewModel.model.isVideoEnable = true
                                    SBManager.shared().directCall?.startVideo()
                                }
                           } else {
                            Image("btnVideoOffSelected") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .resizable()
                                .frame(width: size, height: size)
                                .onTapGesture {
                                    self.viewModel.model.isVideoEnable = false
                                    SBManager.shared().directCall?.stopVideo()
                                }
                           }

                       Image("btnCallEnd") .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                           .resizable()
                           .frame(width: size, height: size)
                           .onTapGesture {
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
    
    /*
    func setupVideoView() {
        let localSBVideoView = SendBirdVideoView(frame: localVideoView?.frame ?? CGRect.zero)
        let remoteSBVideoView = SendBirdVideoView(frame: view?.frame ?? CGRect.zero)
        
        self.call.updateLocalVideoView(localSBVideoView)
        self.call.updateRemoteVideoView(remoteSBVideoView)
        
        self.localVideoView?.embed(localSBVideoView)
        self.view?.embed(remoteSBVideoView)
        
        self.mirrorLocalVideoView(isEnabled: true)
    }
    
    func resizeLocalVideoView() {
        // Local video view: full screen -> left upper corner small screen
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            var topSafeMargin: CGFloat = 0
            var bottomSafeMarging: CGFloat = 0
            if #available(iOS 11.0, *) {
                topSafeMargin = self.view.safeAreaInsets.top
                bottomSafeMarging = self.view.safeAreaInsets.bottom
            }
            // Resize as width: 96, height: 160
            self.leadingConstraint.constant = 16
            self.trailingConstraint.constant = self.view.frame.width - 112 // (leadingConstraint + local video view width)
            self.topConstraint.constant = 16
            self.bottomConstraint.constant = self.view.frame.maxY - (topSafeMargin + bottomSafeMarging) - 176 // (topConstraint + video view height)
            self.view.layoutIfNeeded()
        })
    }
    
    func mirrorLocalVideoView(isEnabled: Bool) {
        guard let localSBView = self.localVideoView?.subviews.first else { return }
        switch isEnabled {
        case true: localSBView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        case false: localSBView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    // SendBirdCalls: Start / Stop Video
    func updateLocalVideo(isEnabled: Bool) {
        self.videoOffButton.setBackgroundImage(UIImage(named: isEnabled ? "btnVideoOffSelected" : "btnVideoOff"), for: .normal)
        if isEnabled {
            call.stopVideo()
            self.localVideoView?.subviews[0].isHidden = true
        } else {
            call.startVideo()
            self.localVideoView?.subviews[0].isHidden = false
        }
    }
     */
}

struct VideoCallUIView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCallUIView()
    }
}
