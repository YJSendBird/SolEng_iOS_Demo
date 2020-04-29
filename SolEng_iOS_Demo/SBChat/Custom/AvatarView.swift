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
    @State var image:UIImage = UIImage()

    init(url:String) {
        print("AvatarView Url = ", url)
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        Image(uiImage: /*imageLoader.data != nil ? UIImage(data:imageLoader.data!)! :*/ UIImage(named: "iconAvatar")!)
            .resizable()
            .frame(width: size, height: size)
            .border(Color.gray.opacity(0.5), width: 0.5)
            .cornerRadius(size/2)
    }
}
