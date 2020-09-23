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
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .center) {

                    ScrollView {
                        ForEach(posts, id: \.time) {post in
                            ListCell(post: post)
                        }
                    }.padding()
                    .navigationBarTitle("the Wall")
                    
                    
                    NavigationLink(destination: NewPostView()) {
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

