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
        MainViewListItem(id: 0, name: "Users"),
        MainViewListItem(id: 1, name: "Group Channel Sync"),
        MainViewListItem(id: 2, name: "Group Channel Basic"),
        MainViewListItem(id: 3, name: "Open Channel"),
    ]

    var body: some View {
        NavigationView {
            List(menuItems) { menuItem in
                //사용자 리스트
                if menuItem.id == 0 {
                    NavigationLink(destination: UserUIView()) {
                        MainViewListItemRow(item : menuItem)
                    }
                }  else if menuItem.id == 1 {
                    NavigationLink(destination: GroupChannelSyncList()) {
                        MainViewListItemRow(item : menuItem)
                    }
                }  else if menuItem.id == 2 {
                   NavigationLink(destination: GroupChannelList()) { //TODO - Group Channel Basic
                       MainViewListItemRow(item : menuItem)
                   }
                }  else if  menuItem.id == 3 {
                   NavigationLink(destination: OpenChannelList()) {
                       MainViewListItemRow(item : menuItem)
                   }
                } 
            }
            .navigationBarTitle(Text("SendBird Chat Demo"))
            .navigationBarItems(trailing:
                HStack {
                    Button("Logout") {
                        SBManager.shared().logOut()
                    }
            })
            .navigationBarItems(leading:
                HStack {
                Button(UserDefaults.standard.user.id) {
                        //SBManager.shared().logOut()
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
