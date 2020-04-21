//
//  GroupChannelViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/09.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SendBirdSyncManager

final class GroupChannelViewModel: ObservableObject {
    @Published var lists = [GroupChannelModel]() 
}
