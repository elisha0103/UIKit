//
//  DetailsMovie.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct DetailsMovie: Codable {
    let audience, grade: Int
    let actor: String
    let duration, reservationGrade: Int
    let title: String
    let reservationRate, userRating: Double
    let date, director, id: String
    let image: String
    let synopsis, genre: String

    enum CodingKeys: String, CodingKey {
        case audience, grade, actor, duration
        case reservationGrade = "reservation_grade"
        case title
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
        case date, director, id, image, synopsis, genre
    }
}
