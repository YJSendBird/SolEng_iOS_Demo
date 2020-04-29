//
//  ImageLoader.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/21.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation

class ImageLoader: ObservableObject {
    @Published var data:Data?

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error.debugDescription)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

