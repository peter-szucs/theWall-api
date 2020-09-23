//
//  NewPostView.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-22.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
    @State private var post: PostObject = PostObject(author: "", post: "", time: "")
    @State private var showingAlert = false
    @State private var alertDone = false
    @State private var selection: Int?
    
//    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "person").foregroundColor(.gray)
                TextField(/*@START_MENU_TOKEN@*/"Författare"/*@END_MENU_TOKEN@*/, text: $post.author)
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 2))
            .navigationBarTitle("Nytt Inlägg")
            HStack {
                
                if #available(iOS 14.0, *) {
                    
                    TextEditor(text: $post.post)
                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                } else {
                    TextField("Inlägg...", text: $post.post)
                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 2))
            .padding(.bottom, 30)
    
            Button(action: sendPost) {
                Text("Posta")
                    .font(.headline)
                    .padding(.horizontal, 30.0).padding(.vertical, 15)
                    .foregroundColor(.primary)
                    .background(Color("ButtonBackground"))
                    .cornerRadius(5)
            }
            
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Varning!"), message: Text("Var vänlig fyll i alla fält för att posta."), dismissButton: .default(Text("Ok")))
            }
            .alert(isPresented: $alertDone) {
                Alert(title: Text("Din post är upplagd!"), message: Text("Tryck på bakåtknappen för att gå tillbaka."), dismissButton: .default(Text("Ok")))
            }
            
            .padding(.bottom, 15.0)
            
        }
    .padding(.horizontal, 20.0)
        .onAppear() {
            print(getTimeString())
        }
        
    }
    
    func sendPost() {
        print("Name: \(post.author) Post: \(post.post)")
        if (post.author == "" || post.post == "") {
            // Alert för fyll i allt
            showingAlert = true
            return
        } else {
            // Skicka till API och gå tillbaks till listan
            let currentTime = getTimeString()
            let postPost = PostToPost(author: post.author, post: post.post, time: currentTime)
            
            let postRequest = ApiRequest()
            postRequest.postToApi(postPost, completion: { result in
                switch(result) {
                case .success(let postObject):
                    print("The following message has been sent: \(postObject.post)")
                    alertDone = true
//                    self.presentationMode.wrappedValue.dismiss()
                case .failure(let error):
                    print("An error has occured \(error)")
                }
            })
            
        }
    }
    
    func getTimeString() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y, HH:mm"
        return formatter.string(from: now)
    }
    
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
