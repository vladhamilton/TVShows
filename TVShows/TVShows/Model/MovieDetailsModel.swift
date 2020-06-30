//
//  MovieDetailsModel.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 28.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import Foundation

// MARK: - MovieDetailsModel
struct MovieDetailsModel: Codable {
    let backdropPath: String?
    let genres: [Genre]?
    let overview: String?
    let releaseDate: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, overview
        case releaseDate = "release_date"
        case title
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String?
}

extension MovieDetailsModel {
    init() {
        self.backdropPath = ""
        self.genres = nil
        self.overview = ""
        self.releaseDate = ""
        self.title = ""
    }
}
