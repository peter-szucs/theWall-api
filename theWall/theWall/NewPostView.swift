//
//  NewPostView.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-22.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
    var isEditing: Bool
    @State var editPost: PostObject
//    @State private var post: PostObject = PostObject(author: "", post: "", time: "")
    @State private var showingAlert = false
    @State private var alertDone = false
    @State private var alertDelete = false
//    @State private var selection: Int?
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "person").foregroundColor(.gray)
                if !isEditing {
                    TextField("Författare", text: $editPost.author)
                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                        .keyboardType(.alphabet)
                        .textContentType(.name)
                } else {
                Text(editPost.author)
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .keyboardType(.alphabet)
                    .textContentType(.name)
                }
                Spacer()
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
            .navigationBarTitle("Nytt Inlägg")
            
            HStack {
                
                if #available(iOS 14.0, *) {
                    
                    TextEditor(text: $editPost.post)
                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                        .keyboardType(.twitter)
                        
                } else {
                    TextField("Inlägg...", text: $editPost.post)
                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
            .padding(.bottom, 30)
            
    
            HStack {
                Button(action: sendPost) {
                    Text(buttonText())
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
                    Alert(title: Text(alertEditingTexts()), message: Text("Tack för ditt bidrag till väggen."), dismissButton: .default(Text("Ok"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                }
                if isEditing {
                    Spacer()
                    Button(action: deletePost) {
                        Text("Ta bort")
                            .font(.headline)
                            .padding(.horizontal, 30.0).padding(.vertical, 15)
                            .foregroundColor(.white)
                            .background(Color(.systemRed))
                            .cornerRadius(5)
                    }
                    .alert(isPresented: $alertDelete) {
                        Alert(title: Text("Din post är borttagen!"), message: Text("Hoppas det var värt det..."), dismissButton: .default(Text("Ok"), action: {
                            presentationMode.wrappedValue.dismiss()
                        }))
                    }
                }
                
            }
            
            
            .padding(.bottom, 15.0)
            
        }
        .padding()
        .onAppear() {
            print(getTimeString())
        }
        
    }
    
    func alertEditingTexts() -> String {
        if isEditing {
            return "Posten är uppdaterad."
        } else {
            return "Din post är upplagd!"
        }
    }
    
    func buttonText() -> String {
        if isEditing {
            return "Ändra"
        } else {
            return "Posta"
        }
    }
    
    func deletePost() {
        let currentTime = getTimeString()
        let postRequest = ApiRequest()
        postRequest.postToApi(editPost, httpMethod: "DELETE", statusCode: 200, time: currentTime, completion: { result in
            switch(result) {
            case .success(_):
                alertDelete = true
            case .failure(let error):
                print("An error has occured \(error)")
            }
                              
        })
    }
    
    func sendPost() {
        print("Name: \(editPost.author) Post: \(editPost.post)")
        if (editPost.author == "" || editPost.post == "") {
            // Alert för fyll i allt
            showingAlert = true
            return
        } else {
            // Skicka till API och gå tillbaks till listan
            let currentTime = getTimeString()
//            let postPost = PostToPost(author: editPost.author, post: editPost.post, time: currentTime)
            var statusCode: Int = 0
            var httpMethod: String = ""
            if !isEditing {
                statusCode = 201
                httpMethod = "POST"
            } else {
                statusCode = 200
                httpMethod = "PUT"
            }
            let postRequest = ApiRequest()
            postRequest.postToApi(editPost, httpMethod: httpMethod, statusCode: statusCode, time: currentTime, completion: { result in
                switch(result) {
                    case .success(let postObject):
                        print("The following message has been sent: \(postObject.post)")
                        alertDone = true
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
        NewPostView(isEditing: true, editPost: PostObject(id: "lhj", author: "Peter", post: "Hej", time: "20 Aug 2020, 12:23"))
    }
}
