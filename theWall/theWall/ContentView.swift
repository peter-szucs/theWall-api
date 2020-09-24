//
//  ContentView.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-21.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var posts: [PostObject] = []
//    @State private var showingAlert = false
    @State private var showEdit = false
    @State private var selectedPost = PostObject(id: "", author: "", post: "", time: "")
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {

                ScrollView {
                    ForEach(posts, id: \.id) { post in
                        NavigationLink(destination: NewPostView(isEditing: true, editPost: post)) {
                            ListCell(post: post)
//                                .onTapGesture {
//                                print("Klickade: \(post.id)")
//                                showEdit.toggle()
//                                selectedPost = post
//                            }
                                .foregroundColor(.primary)
                        }
                        
                    }
//                    .navigate(to: NewPostView(isEditing: true, editPost: selectedPost), when: $showModal)
                    
                    
                }
                .padding()
                .navigationBarTitle("the Wall")
                
                
                NavigationLink(destination: NewPostView(isEditing: false, editPost: PostObject(id: "", author: "", post: "", time: ""))) {
                    Text("Nytt Inlägg")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color("ButtonBackground"))
                        .cornerRadius(5)
                    
                }
                .padding(.bottom)
                
                .onAppear() {
                    self.getPosts()
                    UITableView.appearance().separatorStyle = .none
                }
            }
        }
    }
    
    func getPosts() {
        Api().getPosts { (post) in
            self.posts = post
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

//extension View {
//    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
//        NavigationView {
//            ZStack {
//                self
//                    .navigationBarTitle("")
//                    .navigationBarHidden(true)
//                NavigationLink(
//                    destination: view,
//                    isActive: binding
//                ) {
//                    EmptyView()
//                }
//            }
//        }
//    }
//}

