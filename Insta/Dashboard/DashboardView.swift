//
//  DashboardView.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import SwiftUI
import CoreData

protocol DashboardVMP: ObservableObject {
    var isLoading: Bool { get }
    
    func onAppear()
    func loadMorePosts()
    func loadMoreStories()
}

struct DashboardView<ViewModel: DashboardVMP>: View {
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.id, ascending: true)],
        animation: .default
    )
    private var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.id, ascending: true)],
        animation: .default
    )
    private var posts: FetchedResults<Post>

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    storiesView
                    Divider()
                    postsView
                }
            }
        }
        .navigationTitle("Insta")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
        })
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var storiesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 20) {
                addStoryView
                ForEach(users, id: \.id) { user in
                    StoryView(config: .init(user: user))
                        .onAppear {
                            guard let index = users.firstIndex(of: user), index == (users.count - 1) else { return }
                            viewModel.loadMoreStories()
                        }
                }
                Spacer()
            }
            .padding(.horizontal, 12)
        }
    }
    
    @ViewBuilder
    private var postsView: some View {
        ForEach(posts, id: \.id) { post in
            PostView(config: .init(post: post))
                .onAppear {
                    guard let index = posts.firstIndex(of: post), index == (posts.count - 1) else { return }
                    viewModel.loadMorePosts()
                }
        }
    }
    
    private var addStoryView: some View {
        VStack(alignment: .center, spacing: 3) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(LinearGradient(colors: [.red, .purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 60, height: 60, alignment: .center)
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20, alignment: .center)
                    .overlay {
                        Text("+")
                            .foregroundColor(.white)
                            .padding(3)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
            }
            Text("Add")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .lineLimit(2)
        }
        .frame(maxWidth: 60)
    }
}
