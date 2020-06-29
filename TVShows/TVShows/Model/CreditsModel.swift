//
//  CreditsModel.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 28.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import Foundation

// MARK: - CreditsModel
struct CreditsModel: Codable {
    let cast: [Cast]?
    let crew: [Crew]?
}

// MARK: - Cast
struct Cast: Codable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - Crew
struct Crew: Codable {
    let job, name: String?
    
    enum CodingKeys: String, CodingKey {
        case job, name
    }
}
