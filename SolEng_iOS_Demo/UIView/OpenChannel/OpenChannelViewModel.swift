//
//  OpenChannelViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/07.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SendBirdSyncManager

final class OpenChannelViewModel {
    var lists = [OpenChannelModel]() {
        didSet {
            didChange.send(self)
        }
    }
    let didChange = PassthroughSubject<OpenChannelViewModel, Never>()
}
