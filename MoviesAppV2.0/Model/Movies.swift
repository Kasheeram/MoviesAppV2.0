//
//  Movies.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 01/07/22.
//

import Foundation


struct Movies: Decodable {
    let page: Int?
    let results: [Resultt]?
    let totalPages, totalResults: Int?
}

// MARK: - Result
struct Resultt: Decodable {
//    let adult: Bool?
//    let backdropPath: String?
//    let genreIDS: [Int]?
    let id: Int?
//    let originalLanguage: OriginalLanguage?
//    let originalTitle, overview: String?
//    let popularity: Double?
    let posterPath, releaseDate, title: String?
//    let video: Bool?
    let voteAverage: Double?
//    let voteCount: Int?
}

//enum OriginalLanguage: Decodable {
//    case en
//    case es
//}
