//
//  TMDBRequest.swift
//  MediaProject
//
//  Created by 박성민 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBRequest {
    case sameMovie(movieID: String)
    case recommendMovie(movieID: String)
    case poster(movieID: String)
    
    var filterStyle: String {
        switch self {
        case .sameMovie:
            return "similar"
        case .recommendMovie:
            return "similar" // Maybe a typo; should be different if needed
        case .poster:
            return "images"
        }
    }
    
    var TMDBToken: String {
        return APIKey.TMDBToken
    }
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    var header: HTTPHeaders {
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": self.TMDBToken
        ]
        return header
    }
    
    func requestURL(movieID: String) -> String {
        return "\(baseURL)\(movieID)/\(filterStyle)"
    }
}