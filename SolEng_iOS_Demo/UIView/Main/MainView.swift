//
//  ContentView.swift
//  SolEng_iOS_Demo
//
//  Created by YongjunChoi on 2020/03/16.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI


struct MainView: View {
    var menuItems = [
        MenuItem(id: 0 , name: "Group Channel"),
        MenuItem(id: 1 , name: "Open Channel"),
        MenuItem(id: 2 , name: "Broadcast Channel"),
        MenuItem(id: 3 , name: "SendBird Call")
    ]

    var body: some View {
        NavigationView {
            List(menuItems) { menuItem in
                NavigationLink(destination: ChatView()) {
                    MenuItemRow(item : menuItem)
                }
            }
            .navigationBarTitle(Text("Choose Test Case"))
            .navigationBarItems(trailing:
                HStack {
                    Button("logout") {
                        print("About tapped!")
                        GlobalValues.sharedInstance.userId = ""
                    }
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
