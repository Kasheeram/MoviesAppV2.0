//
//  MovieDetails.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 01/07/22.
//

import Foundation


// MARK: - Welcome1
struct MovieDetails: Decodable {
    let adult: Bool?
    let backdropPath: String?
//    let belongsToCollection: NSNull?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Decodable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?
}

// MARK: - ProductionCountry
struct ProductionCountry: Decodable {
    let iso3166_1, name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Decodable {
    let englishName, iso639_1, name: String?
}
