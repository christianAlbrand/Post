//
//  PostView.swift
//  Post
//
//  Created by Christian-SDGKU on 21/09/26.
//

import SwiftUI
import Combine

struct PostView: View {
    
    @StateObject var viewModel: PostViewModel = PostViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    if !viewModel.errormessage.isEmpty {
                        
                        VStack(spacing: 16) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 45))
                                .foregroundStyle(.orange)
                            
                            Text("Something went wrong")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(viewModel.errormessage)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Button {
                                //Because the button triggers async work it needs to be inside a Task{} component
                                Task {
                                    //We still need to mark this task as await
                                    await viewModel.loadPost()
                                }
                            } label: {
                                Label("RETRY", systemImage: "arrow.clockwise")
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    } else {
                        
                        List(viewModel.post) { post in
                            VStack(alignment: .leading, spacing: 12) {
                                
                                HStack {
                                    Image(systemName: "book.pages.fill")
                                        .font(.title3)
                                        .foregroundStyle(.blue)
                                    
                                    Text("POST #\(post.id)")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                }
                                
                                Text(post.title.capitalized)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                                
                                Text(post.body)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineSpacing(3)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            )
                            .listRowInsets(
                                EdgeInsets(
                                    top: 6,
                                    leading: 16,
                                    bottom: 6,
                                    trailing: 16
                                )
                            )
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await viewModel.loadPost()
        }
    }
}

#Preview {
    PostView()
}
