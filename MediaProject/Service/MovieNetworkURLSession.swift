//
//  MovieNetworkURLSession.swift
//  MediaProject
//
//  Created by 박성민 on 6/30/24.
//

import Foundation
enum MovieError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}
class MovieNetworkURLSession {
    static let shard = MovieNetworkURLSession()
    private init() {}
    
    func callRequest<T:Decodable>(id: Int, movieEnum: TMDBRequest, page: Int = 1, decodeType: T.Type, completionHandler: @escaping (T?,MovieError?) -> Void) {
        let url = URL(string:movieEnum.requestURL(movieID: String(id)))!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.headers = movieEnum.header
        request.setValue("page", forHTTPHeaderField: String(page))
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //결과, 상태코드, 에러
            guard error == nil else {
                completionHandler(nil, .failedRequest)
                return
            }
            guard let response = response else {
                completionHandler(nil, .invalidResponse)
                return
            }
            //error가 nil인 상황, data가 있는 상황
            guard let data = data else {
                completionHandler(nil, .noData)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(nil, .invalidResponse)
                return
            }
            guard response.statusCode == 200 else {
                completionHandler(nil, .failedRequest)
                return
            }
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                completionHandler(result, nil)
            }catch {
                print(error.localizedDescription)
                completionHandler(nil, .invalidData)
            }
        }.resume()
        
    }
}



//func callMovieRequset<T:Decodable>(movieId: Int, movieEnum: TMDBRequest, page: Int = 1,decodeType: T.Type, completionHandler: @escaping (T?,String?) -> Void) {
//    let url = movieEnum.requestURL(movieID: String(movieId))
//    let header: HTTPHeaders = movieEnum.header
//    let param: Parameters = [
//        "page": page
//    ]
//    AF.request(url,method: .get,parameters: param, headers: header)
//        .validate(statusCode: 200..<500)
//        .responseDecodable(of: T.self) {respons in
//            switch respons.result{
//            case .success(let value):
//                completionHandler(value,nil)
//
//            case .failure(_):
//                completionHandler(nil,"에러")
//            }
//        }
//}
