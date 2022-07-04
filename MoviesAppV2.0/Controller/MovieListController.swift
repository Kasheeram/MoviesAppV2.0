//
//  MovieListController.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 30/06/22.
//

import UIKit

class MovieListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let tableData = ["Mahadev", "Krishna", "Brahmadev", "Sai baba"]
    
    let identifier = "Cell"
    var movieViewModel = [MovieViewModel]()
    var totalEntries = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First"
        setupUI()
        getMovieList()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func getMovieList() {
//        let urlString = baseURL + "/3/movie/popular?api_key=\(apiKey)&page=\(1)"
        Services.shared.fetchGenericData(from: .popular) { (result: Result<Movies, MovieError>) in
            switch result {
            case .success(let response):
                if let result = response.results, let totalResult = response.totalResults {
                    self.movieViewModel += result.map({ return MovieViewModel(result: $0)})
                    self.totalEntries = totalResult
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieListCell
//        cell.label.text = movieViewModel[indexPath.row].title
//        cell.label.backgroundColor = .red
        cell.movieViewModel = movieViewModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = movieViewModel[indexPath.row].id
        let VC = MovieDetailController.controller()
        VC.movieId = id
        navigationController?.pushViewController(VC, animated: true)
    }
}
