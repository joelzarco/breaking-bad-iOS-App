//
//  ViewModel.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 28/08/25.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    enum FetchStatus{
        case notStarted
        case fetching
        case success
        case failed(error : Error)
    }
    
    private(set) var status : FetchStatus = .notStarted // no one outside here can modify this value, only in this class can change its value
    
    private let fetcher = FetchService()
    
    var quote : Quote
    var character : Char
    
    init () {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // decode from sample data in bundle files, since it has been tested we can use try!
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        
        quote = try! decoder.decode(Quote.self, from: quoteData)
        // Now for character from sample data
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Char.self, from: characterData)
        // death data is decoded inside char model
    }
    
    func getData(for show: String) async{
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .success
        } catch{
            status = .failed(error: error)
        }
    }
}
