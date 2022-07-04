//
//  MovieDetailController.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 01/07/22.
//

import UIKit
import SDWebImage
import Cosmos

class MovieDetailController: UIViewController {
    @IBOutlet weak var StarsViewWidthLayout: NSLayoutConstraint!
    @IBOutlet weak var StarsViewHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var fractionTimingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var directorsLabel: UILabel!
    @IBOutlet weak var producersLabel: UILabel!
    @IBOutlet weak var cosmosVeww: CosmosView!
    @IBOutlet weak var separatorView: UIView!
    
    
    @IBOutlet weak var starringLabel: UILabel!
    
    let starr = ["Kashee", "Ajay", "Parakash", "Kashee", "Ajay", "Parakash", "Kashee", "Ajay", "Parakash", "Kashee", "Ajay", "Parakash", "Kashee", "Ajay", "Parakash"]
    
    var movieId: Int?
    var movieDetailViewModel: MovieDetailViewModel? {
        didSet {
            if let movieDetailViewModel = movieDetailViewModel {
                titleLabel.text = movieDetailViewModel.title
                if let posterPath = movieDetailViewModel.posterPath {
                    let imgFullPath = imageBaseUrl + posterPath
                    posterImageView.sd_setImage(with: URL(string:imgFullPath), completed: nil)
                }
                fractionTimingLabel.text = "\(movieDetailViewModel.originalTitle ?? ""), \(movieDetailViewModel.yearText ), \(movieDetailViewModel.durationText)"
                summaryLabel.text = movieDetailViewModel.overview
                ratingLabel.text = movieDetailViewModel.scoreText
                cosmosVeww.rating = movieDetailViewModel.voteAverage ?? 0.0
                directorsLabel.text = "Joss Weddon"
                producersLabel.text = "Kevin Feige"
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails()
        var combineText = ""
        for i in 0..<starr.count {
            combineText += starr[i] + "\("\n")"
        }
        let finalText = NSAttributedString(string: combineText).withLineSpacing(6)
        starringLabel.attributedText = finalText
        starringLabel.text = combineText
        separatorView.layer.opacity = 0.8
   
    }
    
    override func viewWillLayoutSubviews() {
        let height = starringLabel.attributedTextHeight(withWidth: self.StarsViewWidthLayout.constant)
        self.StarsViewHeightLayout.constant = height + 20
        
        // In same way you can calculate the height of Director View's label and compare height b/w
        // StaringViewHeight and DirectorViewHeight and assign only maxView height
        // self.StarsViewHeightLayout.constant = height + 20
    }
    
    // MARK: - Intialization
    class func controller() -> MovieDetailController {
        return MovieDetailController(nibName: "MovieDetailController", bundle: nil)
    }
    
    func getMovieDetails() {
        guard let movieId = movieId else { return }
//        let urlString = baseURL + "/3/movie/\(movieId)?api_key=\(apiKey)"
        Services.shared.fetchMovie(id: movieId) { ( result: Result<MovieDetails, MovieError>) in
            switch result {
            case .success(let response):
                self.movieDetailViewModel = MovieDetailViewModel(movieDetails: response)
            case .failure(let error):
                print(error)
            }
        }
    }
  


}
