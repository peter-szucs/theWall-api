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
    var post = PostObject(author: "Peter", post: "I am a happy camper. Out to camp all day, fish among the seas, lorem with the ipsum. As the dolor taketh away.", time: "2020-09-23, 11:01")
    
    var body: some View {
        VStack() {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(post.author).font(.headline).multilineTextAlignment(.leading).padding(.vertical, 10.0)
                        Spacer()
                        Text(post.time).font(.caption)
                    }
                    Text(post.post)
                    
                    HStack {
                        Spacer()
                        Text("Replies: 0")
                            .font(.subheadline)
                            .padding(.vertical, 10.0)
                    }
                }
                Spacer()
            }
            
            .padding()
        }
//        .padding(.horizontal, 10.0)
//        .frame(width: 350.0)
        .background(Color("MessageBackground"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.lightGray), lineWidth: 1)
        )
        
//        .background(Color(.sRGB, red: 200/255, green: 200/255, blue: 230/255, opacity: 0.6))
        
//        padding([.top, .horizontal])
    }
    
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell()
    }
}
