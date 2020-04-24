//
//  RootUIView.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/23.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI
    
struct RootView: View {

    @ObservedObject var viewRouter = SBManager.shared().viewRouter

    var body: some View {
        VStack {
            if viewRouter.currentPage == ViewRouter.PageEnum.loginView {
                AnyView(LoginView())
            } else { //MainView
                AnyView(MainView())
            }
            //viewRouter.currentPage.count > 0 ? AnyView(MainView()) : AnyView(LoginView())
        }
    }
}

struct RootUIView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewRouter: ViewRouter())
    }
}
