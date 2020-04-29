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

final class VideoCallViewModel {
    var model = VideoCallModel() {
        didSet {
            didChange.send(self)
        }
    }
    let didChange = PassthroughSubject<VideoCallViewModel, Never>()
}

