//
//  StoryView.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import SwiftUI

struct StoryView: View {
    
    struct Config: Hashable {
        let url: URL?
        let fullName: String
        
        init(url: URL, fullName: String) {
            self.url = url
            self.fullName = fullName
        }
    }
    
    let config: Config
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            Circle()
                .fill(LinearGradient(colors: [.red, .purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 60, height: 60, alignment: .center)
                .overlay {
                    image
                }
            Text(config.fullName)
                .multilineTextAlignment(.center)
                .font(.footnote)
                .lineLimit(2)
        }
        .frame(maxWidth: 60)
        
    }
    
    private var image: some View {
        AsyncImage(url: config.url) { image in
            image
                .resizable()
        } placeholder: {
            Color.gray
        }
        .clipShape(Circle())
        .padding(4)
    }
    
}

extension StoryView.Config {
    init(user: User) {
        url = user.avatar
        fullName = user.fullName
    }
}
