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
    case recommend
    case poster
}
class MoveNetwork {
    static let shard = MoveNetwork()
    
    private init() {}
    // MARK: - 통신 부분
    func callRequset(moveId: Int, moiveFilter: FilterNetworkStyle, page: Int = 1) {
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
                    dump(value)
                    //성공할 경우 받은 데이터를 핸들링 해주는 함수를 통해 클린 코드진행
                    
                case .failure(let error):
                    //실패 경우
                    print(error)
                }
            }
    }
    // MARK: - 통신 성공 핸들링 부분
//    func succesNetWork(data: <#객체#>) {
//        //네트워크 성공 시 핸들링
//    }
}
