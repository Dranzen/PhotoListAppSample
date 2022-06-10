//
//  PhotosViewModel.swift
//  PhotoApp
//
//  Created by jesse.d.danganan on 6/7/22.
//

import Foundation
import Combine

protocol PhotosViewModel {
    func getPhotoDetails()
}

enum ResultState {
    case loading
    case failed(error: Error)
    case success(content: [Result])
}

class PhotosViewModelImpl: ObservableObject, PhotosViewModel {
    
    private let service: PhotosService
    
    private(set) var photoDetails = [Result]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: PhotosService) {
        self.service = service
    }
    
    func getPhotoDetails() {
        
        self.state = .loading
        
        let  cancellable = self.service
            .request(from: .getPhotos)
            .sink { (res) in
                switch res {
                case .finished:
                    self.state = .success(content: self.photoDetails)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { res in
                self.photoDetails = res
            }
    
        self.cancellables.insert(cancellable)

    }
    
    
}
