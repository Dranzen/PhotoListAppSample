//
//  PhotosService.swift
//  PhotoApp
//
//  Created by jesse.d.danganan on 6/7/22.
//

import Foundation
import Combine

protocol PhotosService {
    func request(from endpoint: PhotosAPI) -> AnyPublisher<[Result], APIError>
}

struct  PhotosServiceImpl: PhotosService {
    func request(from endpoint: PhotosAPI) -> AnyPublisher<[Result], APIError> {
        let jsonDecoder = JSONDecoder()
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<[Result], APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: [Result].self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
