//
//  WeekMovieModel.swift
//  MediaProject
//
//  Created by 박성민 on 6/10/24.
//

import Foundation

struct WeekMovieModel: Codable{
    let results:[Movie]
}
struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let release_date: String
    let vote_average: Double
    
}
//"backdrop_path": "/fY3lD0jM5AoHJMunjGWqJ0hRteI.jpg",
//            "id": 940721,
//            "original_title": "ゴジラ-1.0",
//            "overview": "In postwar Japan, Godzilla brings new devastation to an already scorched landscape. With no military intervention or government help in sight, the survivors must join together in the face of despair and fight back against an unrelenting horror.",
//            "poster_path": "/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg",
//            "media_type": "movie",
//            "adult": false,
//            "title": "Godzilla Minus One",
//            "original_language": "ja",
//            "genre_ids": [
//                878,
//                27,
//                28
//            ],
//            "popularity": 898.788,
//            "release_date": "2023-11-03",
//            "video": false,
//            "vote_average": 7.632,
//            "vote_count": 1563
//        },
