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
                QuoteView(show:"Breaking Bad")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            
            Tab("BetterCallSaul", systemImage: "briefcase"){
                QuoteView(show: "Better Call Saul")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
