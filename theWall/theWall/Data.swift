//
//  Data.swift
//  theWall
//
//  Created by Peter Szücs on 2020-09-21.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct PostObject: Codable, Identifiable {
    let id = UUID()
    var author: String = ""
    var post: String = ""
    
}

enum APIError: Error {
    case resonseProblem
    case decodingProblem
    case encodingProblem
}

struct ApiRequest {
    func postToApi (_ post: PostObject, completion: @escaping(Result<PostObject, APIError>) -> Void) {
        guard let url = URL(string: "https://us-central1-thewall-api.cloudfunctions.net/posts") else { return }
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(post)
            
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.resonseProblem))
                    return
                }
                
                do {
                    let messageData = try JSONDecoder().decode(PostObject.self, from: jsonData)
                    completion(.success(messageData))
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
        guard let url = URL(string: "https://us-central1-thewall-api.cloudfunctions.net/posts") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([PostObject].self, from: data!)
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}


