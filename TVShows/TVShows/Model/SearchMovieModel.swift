//
//  SearchMovieModel.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 29.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import Foundation

// MARK: - SearchMovieModel
struct SearchMovieModel: Codable {
    let page, totalResults, totalPages: Int?
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

