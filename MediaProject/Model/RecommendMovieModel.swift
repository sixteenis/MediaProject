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
    let poster_path: String

    
}
