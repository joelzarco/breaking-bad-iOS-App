//
//  Char.swift
//  BreakingBadQ
//
//  Created by Sergio J. on 27/08/25.
//

import Foundation

// strcuture should be named Character but it is a reserved keyword

struct Char: Decodable{
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL] // there is amethod to parse strings into urls
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death? // in case the char is alive, nil by default, when init we will know its value
}
