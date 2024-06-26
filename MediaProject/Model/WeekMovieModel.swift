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
