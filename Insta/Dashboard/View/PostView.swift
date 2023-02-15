//
//  PostView.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import SwiftUI

struct PostView: View {
    
    struct Config: Hashable {
        let title: String
        let hexContent: String
        
        init(title: String, hexContent: String) {
            self.title = title
            self.hexContent = hexContent
        }
    }
    
    let config: Config
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            headerView
            // NOTE: we can use GeometryReader to get 1:1 ratio
            Rectangle()
                .fill(Color(hex: config.hexContent))
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width, alignment: .center)
            footerView
        }
    }
    
    private var headerView: some View {
        HStack(alignment: .center, spacing: 10) {
            Circle()
                .fill(Color.gray)
                .padding(5)
            Text(config.title)
                .font(.body)
            Spacer()
            Text("···")
        }
        .frame(height: 40)
        .padding(.horizontal, 12)
    }
    
    private var footerView: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "heart")
            Image(systemName: "paperplane")
            Spacer()
            Image(systemName: "note")
        }
        .frame(height: 40)
        .padding(.horizontal, 12)
    }
}

extension PostView.Config {
    init(post: Post) {
        title = post.name
        hexContent = post.color
    }
}

// NOTE: decision from stackoverflow https://stackoverflow.com/questions/56874133/use-hex-color-in-swiftui
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
