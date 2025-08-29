//
//  QuoteView.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 29/08/25.
//

import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show : String
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Image(show.lowercased().replacingOccurrences(of: " ", with: "")) // to acommodate image name
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2) // to make it wider than screen size
                
                VStack{
                    Text("\(vm.quote.quote)") // maybe change last quote to text?
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.4))
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.horizontal)
                    
                    ZStack(alignment: .bottom){
                        AsyncImage(url: vm.character.images[0]){ image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            // image while it´s been downloaded
                            ProgressView()
                        }
                        .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                        
                        Spacer()
                        
                        Text(vm.quote.character)
                            .foregroundStyle(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                    }
                    .frame(width: geo.size.width/1.1, height: geo.size.height/1.8) // modifiers for the image
                    .clipShape(.rect(cornerRadius: 50))
                }
                .frame(width: geo.size.width) // to fit on physical screen
                
            } // Zs
            .frame(width: geo.size.width, height: geo.size.height) // to center the bg image after been enlarged
        } // geo
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
