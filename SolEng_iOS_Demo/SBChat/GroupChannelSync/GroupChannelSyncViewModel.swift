//
//  ChannelViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/03.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SendBirdSyncManager

final class GroupChannelSyncViewModel: ObservableObject {
    @Published var lists = [GroupChannelSyncModel]() 
}
