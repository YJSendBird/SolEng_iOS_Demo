//
//  AvataView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/21.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct AvatarView: View {

    let size: CGFloat = 50

    @ObservedObject var imageLoader:ImageLoader
    let image:UIImage = UIImage(named: "iconAvatar")!

    init(url:String) {
        if url.count == 0  || !url.contains("https://static.sendbird.com") {
            print("AvatarView Url = ", url)
        }
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        Image(uiImage: (imageLoader.data != nil && imageLoader.data!.count > 0) ? UIImage(data:imageLoader.data!)! : image)
            .resizable()
            .frame(width: size, height: size)
            .border(Color.gray.opacity(0.5), width: 0.5)
            .cornerRadius(size/2)
    }
}
