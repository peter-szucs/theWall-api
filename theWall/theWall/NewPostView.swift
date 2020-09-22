//
//  NewPostView.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-22.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
    @State private var post: PostObject?
    @State private var author: String = ""
    @State private var postText: String = ""
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person").foregroundColor(.gray)
                TextField(/*@START_MENU_TOKEN@*/"Författare"/*@END_MENU_TOKEN@*/, text: $author)
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 2))
                
            HStack {
                Image(systemName: "person").foregroundColor(.gray)
                TextField("Inlägg...", text: $postText)
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 2))
        }
        .padding(.horizontal, 20.0)
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
