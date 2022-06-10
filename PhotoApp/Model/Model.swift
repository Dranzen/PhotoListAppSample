//
//  Model.swift
//  PhotoApp
//
//  Created by jesse.d.danganan on 6/6/22.
//

import Foundation


struct Result: Codable, Identifiable {
    let id, author: String
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, url
        case downloadURL = "download_url"
    }
}

typealias Results = [Result]

extension Result {
    static var dummyData: Result {
        .init(id: "0", author: "Alejandro Escamilla", url: "https://unsplash.com/photos/yC-Yzbqy7PY", downloadURL: "https://picsum.photos/id/1025/4951/3301")
    }
}
