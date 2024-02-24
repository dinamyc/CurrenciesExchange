//
//  HelperImage.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation
import SwiftUI

struct HelperImage {
    
    @ViewBuilder
    
    func asyncImageView(with url: URL?) -> some View {
        if let url = url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .cornerRadius(10)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 20)
                .cornerRadius(10)
                .foregroundColor(.gray)
        }
    }
}
