//
//  RoomListViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2021/03/11.
//  Copyright © 2021 YongjunChoi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SendBirdSyncManager

final class RoomListViewModel: ObservableObject {
    @Published var lists = [RoomlListModel]()
}
