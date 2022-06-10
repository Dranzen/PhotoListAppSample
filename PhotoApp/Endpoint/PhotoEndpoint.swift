//
//  PhotoEndpoint.swift
//  PhotoApp
//
//  Created by jesse.d.danganan on 6/7/22.
//

import Foundation


protocol APIBuilder {
    var urlRequest: URLRequest { get }
}

enum PhotosAPI {
    case getPhotos
}

extension PhotosAPI: APIBuilder {
    
    var urlRequest: URLRequest {
        switch self {
        case .getPhotos:
            var request = URLRequest(url: URL(string: "https://picsum.photos/v2/list")!)
            request.addValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            return request
        }
        
    }
}
