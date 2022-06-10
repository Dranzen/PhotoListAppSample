//
//  PhotoView.swift
//  PhotoApp
//
//  Created by jesse.d.danganan on 6/7/22.
//

import SwiftUI
import Kingfisher

struct PhotoView: View {
    
    let photoDetail: Result
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = photoDetail.downloadURL,
               let url = URL(string: image) {
                KFImage(url)
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .shadow(color: Color.gray, radius: 2, x: 4, y: 4)
            }
            NavigationLink(destination: PhotoDetailView(photoDetail: photoDetail)) {
                EmptyView()
            }.opacity(0.0)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photoDetail: Result.dummyData)
    }
}
