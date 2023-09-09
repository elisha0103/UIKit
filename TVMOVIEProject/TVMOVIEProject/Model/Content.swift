//
//  Content.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/29.
//

import Foundation

struct Content: Decodable, Hashable {
    let title: String
    let overView: String
    let posterURL: String
    let vote: String
    let releaseDate: String
    
    init(tv: TV) {
        self.title = tv.name
        self.overView = tv.overView
        self.posterURL = tv.posterURL
        self.vote = tv.vote
        self.releaseDate = tv.firstAirDate
    }
    
    init(movie: Movie) {
        self.title = movie.title
        self.overView = movie.overView
        self.posterURL = movie.posterURL
        self.vote = movie.vote
        self.releaseDate = movie.releaseDate
    }
}
