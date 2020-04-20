//
//  ChatViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/17.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SendBirdSyncManager
import SendBirdSDK

final class ChatViewModel: ObservableObject {
    @Published var lists = [ChatModel]()
}
