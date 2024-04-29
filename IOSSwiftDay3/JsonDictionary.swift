//
//  Dictionary.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 29/04/2024.
//

import Foundation

class JsonDictionary: Codable{
    
    var author: String?
    var title: String?
    var description: String?
    var imageUrl: String?
    var url: String?
    var publishedAt: String?
    
    enum keyConvension: String , CodingKey{
        case author = "author"
        case title = "title"
        case description = "description"
        case imageUrl = "imageUrl"
        case url = "url"
        case publishedAt = "publishedAt"
    }

    
    
}
