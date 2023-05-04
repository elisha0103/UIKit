//
//  DetailsMoviePModel.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct DetailsMoviePModel: Codable {
    let audience, grade: Int
    let actor: String
    let duration, reservationGrade: Int
    let title: String
    let reservationRate, userRating: Double
    let date, director, id: String
    let image: String
    let synopsis, genre: String
    
    static func converTo(detailsMovie: DetailsMovie) -> DetailsMoviePModel {
        return DetailsMoviePModel(
            audience: detailsMovie.audience,
            grade: detailsMovie.grade,
            actor: detailsMovie.actor,
            duration: detailsMovie.duration,
            reservationGrade: detailsMovie.reservationGrade,
            title: detailsMovie.title,
            reservationRate: detailsMovie.reservationRate,
            userRating: detailsMovie.userRating,
            date: detailsMovie.date,
            director: detailsMovie.director,
            id: detailsMovie.id,
            image: detailsMovie.image,
            synopsis: detailsMovie.synopsis,
            genre: detailsMovie.genre
        )
    }
}
