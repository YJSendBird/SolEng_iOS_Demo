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
        MainViewListItem(id: 1, name: "Group Channel Syncmanager"),
        MainViewListItem(id: 2, name: "Group Channel Basic"),
        MainViewListItem(id: 3, name: "Open Channel"),
        MainViewListItem(id: 4, name: "SendBird Voice Call"),
        MainViewListItem(id: 5, name: "SendBird Video Call")
    ]

    var body: some View {
        NavigationView {
            List(menuItems) { menuItem in
                //사용자 리스트
                if menuItem.id == 0 {
                    NavigationLink(destination: UserUIView()) {
                        MainViewListItemRow(item : menuItem)
                    }
                } else if menuItem.id == 1 {
                    NavigationLink(destination: GroupChanneljSyncList()) {
                        MainViewListItemRow(item : menuItem)
                    }
                }  else if menuItem.id == 2 {
                   NavigationLink(destination: GroupChanneljList()) { //TODO - Group Channel Basic
                       MainViewListItemRow(item : menuItem)
                   }
                }  else if  menuItem.id == 3 {
                   NavigationLink(destination: OpenChannelList()) {
                       MainViewListItemRow(item : menuItem)
                   }
                }  else if  menuItem.id == 4{
                   NavigationLink(destination: VoiceCallUIView()) {
                      MainViewListItemRow(item : menuItem)
                   }
                }  else if  menuItem.id == 5{
                     NavigationLink(destination: VideoCallUIView()) {
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
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
