//
//  Data.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-21.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

private var url: String = "https://us-central1-thewall-api.cloudfunctions.net/posts"

struct PostObject: Codable, Identifiable {
//    let id = UUID()
    var id: String = ""
    var author: String = ""
    var post: String = ""
    var time: String = ""
    
}

struct PostToPost: Codable {
    var author: String = ""
    var post: String = ""
    var time: String = ""
}

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct ApiRequest {
    func postToApi (_ postToSave: PostToPost, completion: @escaping(Result<PostToPost, APIError>) -> Void) {
        print(postToSave.post)
        guard let url = URL(string: url) else { return }
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(postToSave)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let postData = try JSONDecoder().decode(PostToPost.self, from: jsonData)
                    completion(.success(postData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
}

class Api {
    func getPosts(completion: @escaping([PostObject]) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([PostObject].self, from: data!)
            
            DispatchQueue.main.async {
                let sortedResult = posts.sorted {
                    $0.time > $1.time
                }
                completion(sortedResult)
            }
        }
        .resume()
    }
}


