//
//  CharacterView.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 30/08/25.
//

import SwiftUI

struct CharacterView: View {
    let character: Char
    let show : String
    
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader{ proxy in
                ZStack(alignment: .top){
                    Image(show.removeCaseAndSpaces())
                        .resizable()
                        .scaledToFit()
                    ScrollView{
                        TabView{
                            ForEach(character.images, id: \.self){ imageURL in
                                AsyncImage(url: imageURL){ image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top, 60)
                        
                        VStack(alignment: .leading){
                            Text(character.name)
                                .font(.largeTitle)
                            Text("Portrayed By:  \(character.portrayedBy)")
                                .font(.subheadline)
                            Divider()
                            Text("Character info:")
                                .font(.title2)
                            Text("Born: \(character.birthday)")
                                .font(.subheadline)
                            ForEach(character.occupations, id: \.self) { occupations in
                                Text("‣ Occupation: \(occupations)")
                            }
                            
                            Divider()
                            
                            Text("Nicknames:")
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id: \.self){ ali in
                                    Text("• \(ali)")
                                        .font(.subheadline)
                                }
                            } else{
                                Text("None")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            DisclosureGroup("Status (spoiler alert!)"){
                                VStack(alignment: .leading) {
                                    Text(character.status)
                                        .font(.title3)
                                    if let death = character.death {
                                        AsyncImage(url: death.image) { im in
                                            im
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear{
                                                    withAnimation{
                                                        proxy.scrollTo(1, anchor: .bottom) // scrll to bottom
                                                    }
                                                }
                                        } placeholder:{
                                            ProgressView()
                                        }
                                        Text("How did \(character.name) die?")
                                        Text(death.details)
                                            .font(.subheadline)
                                            .padding(.bottom, 5)
                                        Text("Last words:")
                                        Text("\"\(death.lastWords)\"")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading) // to fix alignment to leading
                            } // Ds
                            .tint(.primary)
                        } // VS
                        .frame(width: geo.size.width/1.25, alignment: .leading) // To move text Vs to the left
                        .padding(.bottom, 50)
                        .id(1) // to use scrllRdr and got to bottom
                    } // Scrll
                    .scrollIndicators(.hidden)
                } // Zs
            } // ScrllVwRdr
        } // geo
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: Constants.bcsName)
}
