//
//  ContentView.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 26/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("BreakingBad", systemImage: "tortoise"){
                Text("Braking Bad View")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            
            Tab("BetterCallSaul", systemImage: "briefcase"){
                Text("Better call Saul View")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
