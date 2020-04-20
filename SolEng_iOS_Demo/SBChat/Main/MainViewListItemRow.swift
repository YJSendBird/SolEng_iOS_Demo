//
//  MenuItemRow.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/03/24.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import SwiftUI

struct MainViewListItemRow: View {
    
    var item:MainViewListItem

    var body: some View {
        Text(item.name)
    }
}

struct MainViewListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        MainViewListItemRow(item: MainViewListItem(id: 0, name: "menu name"))
    }
}

/*
import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark

    var body: some View {
        Text("Hello World")
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRow(landmark: landmarkData[0])
    }
}
*/

