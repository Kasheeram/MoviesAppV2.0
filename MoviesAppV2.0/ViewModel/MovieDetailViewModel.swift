//
//  MovieDetailViewModel.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 01/07/22.
//

import Foundation


struct MovieDetailViewModel {
    let adult: Bool?
    let backdropPath: String?
//    let belongsToCollection: NSNull?
    let budget: Int?
//    let genres: [Genre]?
    let homepage: String?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
//    let productionCompanies: [ProductionCompany]?
//    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
//    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    init(movieDetails: MovieDetails) {
        self.adult = movieDetails.adult
        self.backdropPath = movieDetails.backdropPath
        self.budget = movieDetails.budget
        self.homepage = movieDetails.homepage
        self.imdbID = movieDetails.imdbID
        self.originalLanguage = movieDetails.originalLanguage
        self.originalTitle = movieDetails.originalTitle
        self.overview = movieDetails.overview
        self.popularity = movieDetails.popularity
        self.posterPath = movieDetails.posterPath
        self.releaseDate = movieDetails.releaseDate
        self.revenue = movieDetails.revenue
        self.runtime = movieDetails.runtime
        self.status = movieDetails.status
        self.tagline = movieDetails.tagline
        self.title = movieDetails.title
        self.video = movieDetails.video
        self.voteAverage = movieDetails.voteAverage
        self.voteCount = movieDetails.voteCount
    }
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
//        genres?.first?.name ?? "n/a"
        ""
    }
    
    var ratingText: String {
        let rating = Int(voteAverage ?? 0.0)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return MovieDetailViewModel.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return MovieDetailViewModel.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
}
