//
//  MoviesViewModel.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 01/07/22.
//

import Foundation

struct MovieViewModel {
    let id: Int?
    let title: String?
    let posterPath: String?
    let voteAvarage: String?
    
    init(result: Resultt) {
        self.id = result.id
        self.title = result.title
        self.posterPath = result.posterPath
        self.voteAvarage = "\(result.voteAverage)"
    }
}
