//
//  ExploreViewController.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 21.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import UIKit

class ExploreViewController: BaseViewController {
    
    //MARK: - Variables
    private var movieList = [Movie]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setDelegates()
        setupSearchController()
        getTrendMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            destination.selectedMovie = sender as? Movie
        }
    }
    
    //MARK: - Private
    private func registerCell() {
        tableView.registerCell(ExploreMovieTableViewCell.self)
        tableView.rowHeight = 150
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    private func getTrendMovies() {
        showActivityIndicator(true)
        NetworkService().getTrendMovies { [weak self] (movies) in
            self?.movieList = movies
            self?.tableView.reloadData()
            self?.showActivityIndicator(false)
        }
    }
    
    private func getSearchMovies(with text: String) {
        showActivityIndicator(true)
        NetworkService().getSearchMovies(search: text) { [weak self] (movies) in
            self?.movieList = movies
            self?.tableView.reloadData()
            self?.showActivityIndicator(false)
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movieList[indexPath.row]
        self.performSegue(withIdentifier: "detailsSegue", sender: selectedMovie)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExploreMovieTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configureCell(movie: movieList[indexPath.row])
        return cell
    }
}

//MARK: - UISearchResultsUpdating
extension ExploreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text != "" {
            getSearchMovies(with: text)
        }
    }
}

//MARK: - UISearchBarDelegate
extension ExploreViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getTrendMovies()
    }
}
