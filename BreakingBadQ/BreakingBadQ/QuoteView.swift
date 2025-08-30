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
                    VStack{ // Second VStack to keep the button in its place
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                            
                        case .success:
                            Text("\(vm.quote.quote)") // maybe change last quote to text?
                                .minimumScaleFactor(0.6) // To avoid cutting longer quotes make text smaller
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
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                            
                        } // switch
                        
                        Spacer()
                    }
                    
                    Button{
                        print("Quote pressed")
                        // we need to to run getData inside a task{}
                        Task{
                            await vm.getData(for: show)
                        }
                    } label: {
                        Text("Get random Quote")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.breakingBadGreen.opacity(0.9))
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(color: .breakingBadYellow, radius: 2)
                    }
                    
                    Spacer(minLength: 100)
                    
                } // VS
                .frame(width: geo.size.width, height: geo.size.height) // to fit on physical screen
                
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
