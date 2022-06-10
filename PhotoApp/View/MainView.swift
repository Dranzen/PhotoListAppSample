//
//  MainView.swift
//  PhotoApp
//
//  Created by jesse.d.danganan on 6/6/22.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @StateObject var viewModel: PhotosViewModelImpl = PhotosViewModelImpl(service: PhotosServiceImpl())
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .success(let content):
                NavigationView {
                    List(content) { photoDetail in
                        PhotoView(photoDetail: photoDetail)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Photo App")
                }
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getPhotoDetails)
            }
            
        }.onAppear {
            self.viewModel.getPhotoDetails()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
