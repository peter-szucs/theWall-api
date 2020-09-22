//
//  ListCell.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-22.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct ListCell: View {
//    var author: String = "Peter"
//    var post: String = "I am a happy camper. Out to camp all day, fish among the seas, lorem with the ipsum. As the dolor taketh away."
    var post = PostObject(author: "Peter", post: "I am a happy camper. Out to camp all day, fish among the seas, lorem with the ipsum. As the dolor taketh away.")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.author).font(.headline).multilineTextAlignment(.leading).padding(.vertical, 10.0)
            Text(post.post)
            HStack {
                Spacer()
                Text("Replies: 0")
                    .font(.subheadline)
                    .padding(.top, 10.0)
            }
//            Spacer()
                
        }
        .padding(.horizontal, 10.0)
//        .frame(width: 350.0)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color(.lightGray)))
        .background(Color(.sRGB, red: 210/255, green: 210/255, blue: 200/255, opacity: 0.3))
        
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell()
    }
}
