//
//  DetailsViewController.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 27.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import UIKit

enum TableSection: Int, CaseIterable {
    case releaseDate, genres, directors, cast, fullDescription
}

class DetailsViewController: BaseViewController {
    
    //MARK: - Variables
    var selectedMovie: Movie?
    private var movie = MovieDetailsModel()
    private var credits = CreditsModel(cast: [Cast](), crew: [Crew]())
    
    //MARK: - Outlets
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        registerCell()
        getMovieDetails()
    }
    
    //MARK: - Private
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCell() {
        tableView.registerCell(DetailsTableViewCell.self)
    }
    
    private func getMovieDetails() {
        showActivityIndicator(true)
        if let selectedMovieId = selectedMovie?.id {
            NetworkService().getMovieDetails(id: selectedMovieId) { [weak self] (movie) in
                self?.movie = movie
                if let poster = movie.backdropPath {
                    self?.posterImageView.downloaded(from: Constants.imageBaseURL + poster, contentMode: .scaleAspectFill)
                }
                self?.tableView.reloadData()
                self?.showActivityIndicator(false)
            }
        }
        getCredits()
    }
    
    private func getCredits() {
        if let selectedMovieId = selectedMovie?.id {
            NetworkService().getCredits(id: selectedMovieId) { [weak self] (credits) in
                self?.credits = credits
                self?.tableView.reloadData()
                self?.showActivityIndicator(false)
            }
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if let tableSection = TableSection(rawValue: indexPath.section) {
            switch tableSection {
            case .releaseDate:
                if let movieReleaseDate = movie.releaseDate {
                    cell.configureCell(with: movieReleaseDate)
                }
            case .genres:
                if let movieGenres = movie.genres {
                    let array = movieGenres.map({$0.name ?? "Name"})
                    cell.configureCell(with: convertToString(from: array))
                }
            case .directors:
                var tempArray = [Crew]()
                if let creditsCrew = credits.crew {
                    creditsCrew.forEach { (element) in
                        if element.job == "Director" {
                            tempArray.append(element)
                        }
                    }
                }
                let array = tempArray.map({$0.name ?? "Name"})
                cell.configureCell(with: convertToString(from: array))
            case .cast:
                if let creditsCast = credits.cast {
                    let array = creditsCast.map({$0.name ?? "Name"})
                    let firstTenElements = Array(array.prefix(10))
                    cell.configureCell(with: convertToString(from: firstTenElements))
                }
            case .fullDescription:
                if let movieOverview = movie.overview {
                    cell.configureCell(with: movieOverview)
                }
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let label = UILabel()
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .releaseDate:
                label.text = "Release date"
            case .genres:
                label.text = "Genres"
            case .directors:
                label.text = "Directors"
            case .cast:
                label.text = "Cast"
            case .fullDescription:
                label.text = "Description"
            }
        }
        return label.text
    }
}
