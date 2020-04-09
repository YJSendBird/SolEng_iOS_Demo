//
//  GlobalValues.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/23.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import Combine

final class RootViewModel {

    let didChange = PassthroughSubject<RootViewModel, Never>()

    var userId = String() {
        didSet {
            didChange.send(self)
        }
    }
}

