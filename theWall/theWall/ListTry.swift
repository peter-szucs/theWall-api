//
//  ListTry.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-22.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct ListTry: View {
    @State var posts: [PostObject] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Tryout for List")
                ScrollView {
                    ForEach(posts) {post in
                        ListCell(post: post)
                    }
                }
                .onAppear {
                    getPosts()
                }
//                List(posts) {item in
//                    ListCell(post: item)
//                }
//                .onAppear() {
//                    getPosts()
//                }
            }.padding()
        }
    }
    
    func getPosts() {
        Api().getPosts { (post) in
            self.posts = post
        }
    }
}

struct ListTry_Previews: PreviewProvider {
    static var previews: some View {
        ListTry()
    }
}
