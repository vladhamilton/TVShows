//
//  NetworkService.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 21.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import Foundation

class NetworkService {
    
    private let request = Request()
    
    func getTrendMovies(completion: @escaping ([Movie]) -> ()) {
        let params: [URLQueryItem] = [URLQueryItem(name: "", value: "")]
        request.getRequest(baseURL: .movie, httpMetod: .GET, apiKey: .movieDataBaseAPI, path: nil, urlParams: params) { (data) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse.results)
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func getMovieDetails(id: Int, completion: @escaping (MovieDetailsModel) -> ()) {
        let params: [URLQueryItem] = [URLQueryItem(name: "", value: "")]
        let path = String(id)
        request.getRequest(baseURL: .movieDetails, httpMetod: .GET, apiKey: .movieDataBaseAPI, path: path, urlParams: params) { (data) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieDetailsModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func getCredits(id: Int, completion: @escaping (CreditsModel) -> ()) {
        let params: [URLQueryItem] = [URLQueryItem(name: "", value: "")]
        let path = String(id) + "/credits"
        request.getRequest(baseURL: .movieCredits, httpMetod: .GET, apiKey: .movieDataBaseAPI, path: path, urlParams: params) { (data) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(CreditsModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func getSearchMovies(search: String , completion: @escaping ([Movie]) -> ()) {
        let params: [URLQueryItem] = [URLQueryItem(name: "query", value: search)]
        request.getRequest(baseURL: .search, httpMetod: .GET, apiKey: .movieDataBaseAPI, path: nil, urlParams: params) { (data) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(SearchMovieModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse.results)
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
}
