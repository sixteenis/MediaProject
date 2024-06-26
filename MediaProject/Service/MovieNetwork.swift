//
//  MoveNetwork.swift
//  MediaProject
//
//  Created by 박성민 on 6/24/24.
//

import Foundation

import Alamofire
//enum FilterNetworkStyle: String{
//    case same = "similar"
//    case recommend = "recommendations"
//    case poster = "images"
//}

class MovieNetwork {
    static let shard = MovieNetwork()
    
    private init() {}
    // MARK: - 통신 부분
    func callMovieRequset(movieId: Int, movieEnum: TMDBRequest, page: Int = 1, completionHandler: @escaping ([RecommendMovies]?,String?) -> Void) {
        let url = movieEnum.requestURL(movieID: String(movieId))
        let header: HTTPHeaders = movieEnum.header
        let param: Parameters = [
            "page": page
        ]
        AF.request(url,method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RecommendMovieModel.self) {respons in
                switch respons.result{
                case .success(let value):
                    completionHandler(value.results,nil)
                    
                case .failure(_):
                    completionHandler(nil,"에러")
                }
            }
    }
    // MARK: - 통신 부분
    func callPosterRequset(movieId: Int, movieEnum: TMDBRequest, page: Int = 1, completionHandler: @escaping ([Posts]?,String?) -> Void) {
        let url = movieEnum.requestURL(movieID: String(movieId))
        let header: HTTPHeaders = movieEnum.header
        let param: Parameters = [
            "page": page
        ]
        AF.request(url,method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: PostModel.self) {respons in
                switch respons.result{
                case .success(let value):
                    completionHandler(value.posters,nil)
                    
                case .failure(_):
                    completionHandler(nil,"에러")
                }
            }
    }
}
