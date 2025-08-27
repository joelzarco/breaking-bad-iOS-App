//
//  Quote.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 27/08/25.
//
// There were properties from json left unused because we will not need for the app

struct Quote : Decodable {
    let quote: String
    let character: String
}
