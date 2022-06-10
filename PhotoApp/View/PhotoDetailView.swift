//
//  PhotoDetailView.swift
//  PhotoApp
//
//  Created by jesse.d.danganan on 6/8/22.
//

import SwiftUI
import Kingfisher

struct PhotoDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let photoDetail: Result
    
    var body: some View {
        VStack(alignment: .center) {
            if let image = photoDetail.downloadURL,
               let url = URL(string: image) {
                KFImage(url)
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(10)
                    .shadow(color: Color.gray, radius: 2, x: 4, y: 4)
            }
            Text("Author")
                .font(.caption)
                .padding(.top, 20.0)
            Text(photoDetail.author)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
        }.padding(.horizontal, 15.0)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photoDetail: Result.dummyData)
    }
}
