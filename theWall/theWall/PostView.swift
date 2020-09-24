//
//  PostView.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-24.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct PostView: View {
    @State var post: PostObject
    @State var showModal: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person").foregroundColor(.gray)
                TextField("Författare", text: $post.author)
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .keyboardType(.alphabet)
                    .textContentType(.name)
            }
            .padding()
//            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
            .navigationBarTitle("Nytt Inlägg")
            HStack {
                
                if #available(iOS 14.0, *) {
                    
                    TextEditor(text: $post.post)
                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                        .keyboardType(.twitter)
                        
                } else {
                    TextField("Inlägg...", text: $post.post)
                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                }
            }
            .padding()
//            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
            .padding(.bottom, 30)
        }
        .padding()
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: PostObject(id: "asdf", author: "Peter", post: "Hej", time: "23 Sep 2020, 14:04"), showModal: true)
    }
}
