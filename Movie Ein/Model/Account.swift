//
//  Account.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 09/09/2023.
//

import Foundation

struct Account: Codable, Identifiable {
    var id: String = UUID().uuidString
    var userName: String?
    var name: String?
    var age: String?
    var birth: String?
    var sex: String?
    var job: String?
    var address: String?
    var url: String?
    var documentID: String?
}
