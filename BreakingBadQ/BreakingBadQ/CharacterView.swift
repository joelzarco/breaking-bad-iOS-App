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
            ZStack(alignment: .top){
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                ScrollView{
                    AsyncImage(url: character.images[0]){ image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
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
                        
                        
                    } // VS
                    .frame(width: geo.size.width/1.25, alignment: .leading) // To move text Vs to the left
                } // Scrll
                .scrollIndicators(.hidden)
            } // Zs
        } // geo
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
}
