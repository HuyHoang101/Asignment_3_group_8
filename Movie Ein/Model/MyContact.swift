//
//  MyContact.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 18/09/2023.
//

import Foundation

struct MyContact: Codable, Identifiable {
    var id: String = UUID().uuidString
    var userName: String?
    var isLike: [String]?
    var isSuprise: [String]?
    var isRating: [String]?
    var documentID: String?
}
