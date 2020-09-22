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
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                List(posts) { post in
                    ListCell(post: post)
                }
                .padding()
                .navigationBarTitle("the Wall")
//                Spacer()
                
                NavigationLink(destination: NewPostView()) {
                    Text("Nytt Inlägg")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color(.sRGB, red: 40/255, green: 170/255, blue: 10/255).opacity(0.6))
                        .cornerRadius(5)
                    
                }
                .padding(.bottom)
                
                .onAppear() {
                    self.getPosts()
                    UITableView.appearance().separatorStyle = .none
                }
                
            }
        }
        
//        .background(Image("brick+wall"))
    }
    
    func getPosts() {
        Api().getPosts { (post) in
            self.posts = post
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
