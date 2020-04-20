//
//  DirectCallDataSource.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import UIKit
import SendBirdCalls

protocol DirectCallDataSource {
    var call: DirectCall! { get set }
    
    var isDialing: Bool? { get set }
}
