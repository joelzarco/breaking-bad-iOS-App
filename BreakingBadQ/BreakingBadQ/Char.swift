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
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case status
        case portrayedBy
        //case death
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        //self.death = try container.decodeIfPresent(Death.self, forKey: .death)
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let deathData = try Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        
        death = try deathDecoder.decode(Death.self, from: deathData)
        
    }
}
