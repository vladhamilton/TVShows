//
//  ExploreMovieTableViewCell.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 21.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import UIKit

class ExploreMovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var shortDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configureCell(movie: Movie) {
        guard let posterPath = movie.posterPath else { return }
        let movieImagePath = Constants.imageBaseURL + posterPath
        
        name.text = movie.title
        shortDescription.text = movie.overview
        poster.downloaded(from: movieImagePath, contentMode: .scaleAspectFit)
    }
}
