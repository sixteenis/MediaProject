//
//  MoveNetwork.swift
//  MediaProject
//
//  Created by 박성민 on 6/24/24.
//

import Foundation

import Alamofire
enum FilterNetworkStyle: String{
    case same = "similar"
    case recommend = "recommendations"
    case poster = "images"
}

class MovieNetwork {
    static let shard = MovieNetwork()
    
    private init() {}
    // MARK: - 통신 부분
    func callRequset(moveId: Int, moiveFilter: FilterNetworkStyle, page: Int = 1, completionHandler: @escaping ([RecommendMovies]?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(moveId)/\(moiveFilter.rawValue)"
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.TMDBToken
        ]
        let param: Parameters = [
            "page": page
        ]
        //method: 통신 방식 ex) GET(요청), Post(생성), PUT(업데이트), DELETE(삭제)
        AF.request(url,method: .get,parameters: param, headers: header)
            .responseDecodable(of: RecommendMovieModel.self) {respons in
                switch respons.result{
                case .success(let value):
                    completionHandler(value.results)
                    
                case .failure(_):
                    //실패 경우
                    
                    completionHandler(nil)
                }
            }
    }
    func callRequsetPost(moveId: Int, moiveFilter: FilterNetworkStyle, page: Int = 1, completionHandler: @escaping ([Posts]?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(moveId)/\(moiveFilter.rawValue)"
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.TMDBToken
        ]
        let param: Parameters = [
            "page": page
        ]
        //method: 통신 방식 ex) GET(요청), Post(생성), PUT(업데이트), DELETE(삭제)
        AF.request(url,method: .get,parameters: param, headers: header)
            .responseDecodable(of: PostModel.self) {respons in
                switch respons.result{
                case .success(let value):
                    completionHandler(value.posters)
                    
                case .failure(_):
                    //실패 경우
                    completionHandler(nil)
                }
            }
    }
}
