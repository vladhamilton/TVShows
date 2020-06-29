//
//  MovieModel.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 21.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let page: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page, results
    }
}

// MARK: - MovieModel
struct Movie: Codable {
    let id: Int
    let overview: String?
    let posterPath: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case posterPath = "poster_path"
        case title
    }
}
