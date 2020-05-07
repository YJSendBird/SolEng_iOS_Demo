//
//  VideoCallViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SendBirdCalls

final class VideoCallViewModel: ObservableObject {
    
    var callTimer: Timer?
    
    @Published var model = VideoCallModel()

    func activeTimer(_ call: DirectCall) {
        model.timer = "00:00"
        
        // Main thread
        self.callTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            let duration = Double(call.duration)
            
            let convertedTime = Int(duration / 1000)
            let hour = Int(convertedTime / 3600)
            let minute = Int(convertedTime / 60) % 60
            let second = Int(convertedTime % 60)
            
            // update UI
            let secondText = second < 10 ? "0\(second)" : "\(second)"
            let minuteText = minute < 10 ? "0\(minute)" : "\(minute)"
            let hourText = hour == 0 ? "" : "\(hour):"
            
            self.model.timer = "\(hourText)\(minuteText):\(secondText)"
            
            // Timer Invalidate
            if call.endedAt != 0, timer.isValid {
                timer.invalidate()
                self.callTimer = nil
            }
        }
    }
}

