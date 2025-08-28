//
//  FetchService.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 27/08/25.
//

import Foundation

struct FetchService {
    
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote{
        // https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
        // Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchUrl = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)]) // show comes from param args
            
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchUrl) // await means it is async
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        // Decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        // return quote
        return quote
    }
    
    
    func fetchCharacter(_ name : String) async throws -> Char {
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        // in this case we need to specify decoding strategy for snake_case properties
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let characters = try decoder.decode([Char].self, from: data) // the api responds with an array of characters from the series even if its only one
        
        return characters[0]
    }
    
    // the api responds with all deaths
    func fetchDeath(for character: String) async throws -> Death?{
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        // in this case we need to specify decoding strategy for snake_case properties
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        // find the data for the requested char
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        // if there is no recorded death, return nil
        return nil
    }
    
}
