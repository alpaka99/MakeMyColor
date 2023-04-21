//
//  TabView.swift
//  MyColorMaker
//
//  Created by user on 2023/04/20.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            // 1.
           RGBFilterView()
                .tabItem {
                    Image(systemName: "list.number")
                    Text("RGB Classify")
                }
            
            // 2.
            TimeLineView()
                .tabItem {
                    Image(systemName: "square.stack.3d.down.right")
                    Text("Time Line")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
