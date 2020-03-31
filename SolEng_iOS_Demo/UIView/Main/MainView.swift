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
        MainViewListItem(id: 0 , name: "Group Channel"),
        MainViewListItem(id: 1 , name: "Open Channel"),
        MainViewListItem(id: 2 , name: "Broadcast Channel"),
        MainViewListItem(id: 3 , name: "SendBird Call")
    ]

    var body: some View {
        NavigationView {
            List(menuItems) { menuItem in
                NavigationLink(destination: ChannelList()) {
                    MainViewListItemRow(item : menuItem)
                }
            }
            .navigationBarTitle(Text("SendBird Chat Demo"))
            .navigationBarItems(trailing:
                HStack {
                    Button("Logout") {
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
