//
//  Request.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 21.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import Foundation

class Request {
    
    enum BaseURL: String {
        case movie
        case movieDetails
        case movieCredits
        case search
        var description: String {
            get {
                switch self {
                case .movie:
                    return "https://api.themoviedb.org/3/trending/movie/week"
                case .movieDetails, .movieCredits:
                    return "https://api.themoviedb.org/3/movie/"
                case .search:
                    return "https://api.themoviedb.org/3/search/movie"
                }
            }
        }
    }
    
    enum ApiKey: String {
        case movieDataBaseAPI
        var description: String {
            get {
                switch self {
                case .movieDataBaseAPI:
                    return "d932dec74e4382869f1dea81aa37ba5a"
                }
            }
        }
    }
    
    enum HttpMetod: String {
        case GET, POST
    }
    
    func getRequest(baseURL: Request.BaseURL, httpMetod: Request.HttpMetod, apiKey: Request.ApiKey, path: String?, urlParams: [URLQueryItem], completion: @escaping (Data?) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var urlComponents = URLComponents(string: baseURL.description)!
        if let path = path {
            urlComponents.path.append(path)
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey.description)
        ]
        
        urlComponents.queryItems?.append(contentsOf: urlParams)
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: urlComponents.url!)
        print(request.url!)
        request.httpMethod = httpMetod.rawValue
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                completion(data)
            } else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
