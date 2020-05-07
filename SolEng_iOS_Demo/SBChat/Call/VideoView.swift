//
//  VideoView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/05/04.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI
import AVFoundation
import AVKit
import SendBirdCalls

struct VideoView: UIViewRepresentable {

    var isLocal:Bool = false
    
    var call:DirectCall?
    
    var view = SendBirdVideoView(frame: CGRect.zero)

    func makeUIView(context: Context) -> UIView {
        if(call != nil) {
            if (isLocal) {
                call!.updateLocalVideoView(self.view)
            } else {
                call!.updateRemoteVideoView(self.view)
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

