//
//  RecommendMovieModel.swift
//  MediaProject
//
//  Created by 박성민 on 6/24/24.
//

import Foundation


struct RecommendMovieModel: Codable{
    let page: Int
    let results: [RecommendMovies]
}
struct RecommendMovies: Codable {
//    let id: Int
//    let title: String
//    let overview: String
    let poster_path: String
//    let release_date: String
//    let vote_average: Double
    
}
