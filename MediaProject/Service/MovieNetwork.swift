//
//  MoveNetwork.swift
//  MediaProject
//
//  Created by 박성민 on 6/24/24.
//

import Foundation

import Alamofire

final class MovieNetwork {
    static let shard = MovieNetwork()
    
    private init() {}
    // MARK: - 통신 부분
    func callMovieRequset<T:Decodable>(movieId: Int, movieEnum: TMDBRequest, page: Int = 1,decodeType: T.Type, completionHandler: @escaping (T?,String?) -> Void) {
        let url = movieEnum.requestURL(movieID: String(movieId))
        let header: HTTPHeaders = movieEnum.header
        let param: Parameters = [
            "page": page
        ]
        AF.request(url,method: .get,parameters: param, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) {respons in
                switch respons.result{
                case .success(let value):
                    completionHandler(value,nil)
                case .failure(_):
                    completionHandler(nil,"에러")
                }
            }
    }
    func callYoutubeRequset<T:Decodable>(movieId: Int, movieEnum: TMDBRequest,decodeType: T.Type, completionHandler: @escaping (T?,String?) -> Void) {
        let url = movieEnum.requestURL(movieID: String(movieId))
        let header: HTTPHeaders = movieEnum.header
        AF.request(url,method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) {respons in
                switch respons.result{
                case .success(let value):
                    completionHandler(value,nil)
                    
                case .failure(_):
                    completionHandler(nil,"에러")
                }
            }
    }
}

