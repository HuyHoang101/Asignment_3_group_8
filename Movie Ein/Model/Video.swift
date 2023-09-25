//
//  Video.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 15/09/2023.
//

import Foundation

struct Video: Identifiable, Decodable {
    var url: String?
    var documentID: String?
    var id: String {
        return NSUUID().uuidString
    }
}
