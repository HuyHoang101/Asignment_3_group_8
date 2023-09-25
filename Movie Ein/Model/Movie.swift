//
//  Movie.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 16/09/2023.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: String = UUID().uuidString
    var ImageUrl: String?
    var TrailerUrl: String?
    var name: String?
    var age: Int?
    var published: Date?
    var category: [String]?
    var owner: String?
    var description: String?
    var rating: [Int]?
    var director: String?
    var actors: [String]?
    var documentID: String?
}
