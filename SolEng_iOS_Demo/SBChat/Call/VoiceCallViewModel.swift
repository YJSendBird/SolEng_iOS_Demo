//
//  VoiceCallViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class VoiceCallViewModel {
    var models = VoiceCallModel(id: "", name: "") {
        didSet {
            didChange.send(self)
        }
    }
    let didChange = PassthroughSubject<VoiceCallViewModel, Never>()
}
