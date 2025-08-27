//
//  FetchService.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 27/08/25.
//

import Foundation

struct FetchService {
    
    enum FetchError: Error {
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
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
    
    
    
}
