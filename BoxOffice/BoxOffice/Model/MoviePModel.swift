//
//  MoviePModel.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct MoviePModel: Codable {
    let grade: Int
    let thumb: String
    let reservationGrade: Int
    let title: String
    let reservationRate, userRating: Double
    let date, id: String
    
    static func converTo(movie: Movie) -> MoviePModel {
        return MoviePModel(
            grade: movie.grade,
            thumb: movie.thumb,
            reservationGrade: movie.reservationGrade,
            title: movie.title,
            reservationRate: movie.reservationRate,
            userRating: movie.userRating,
            date: movie.date,
            id: movie.id
        )
    }
}
