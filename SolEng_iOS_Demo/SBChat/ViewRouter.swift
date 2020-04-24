//
//  GlobalValues.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/23.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    
    enum PageEnum {
         static let mainView = "mainView"
         static let loginView = "loginView"
    }
    
    @Published var currentPage = PageEnum.loginView

}

