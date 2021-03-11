//
//  WebViewModel.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/05/14.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false

    init (link: String) {
        self.link = link
    }
}

