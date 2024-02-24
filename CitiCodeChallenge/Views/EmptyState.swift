//
//  EmptyState.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import SwiftUI

struct EmptyStateView<Content: View>: View {
    var onReload: () -> Void // Callback closure to trigger reloading
    var content: Content

    init(onReload: @escaping () -> Void, content: Content) {
        self.onReload = onReload
        self.content = content
    }

    var body: some View {
        VStack {
            content
            Button(action: {
                self.onReload()
            }) {
                Text(Constants.EmptyStateView.buttonTitle)
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .padding()
            }
        }
    }
}
