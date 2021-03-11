//
//  SwiftUIWebView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/05/14.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI
import Combine
import WebKit

struct SwiftUIWebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel

    let webView = WKWebView()

    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.link) {
            self.webView.load(URLRequest(url: url))
        }
        return self.webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SwiftUIWebView>) {
        return
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel

        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //print("WebView: navigation finished")
            self.viewModel.didFinishLoading = true
        }
    }

    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        Coordinator(viewModel)
    }
}



struct SwiftUIWebView_Previews: PreviewProvider {
    static var previews: some View {

        SwiftUIWebView(viewModel: WebViewModel(link: "https://google.com"))
        //WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
    }
}
