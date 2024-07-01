//
//  VideoModel.swift
//  MediaProject
//
//  Created by 박성민 on 7/1/24.
//

import Foundation

struct VideoModel:Decodable {
    let results: [VideoIDModel]
}

struct VideoIDModel: Decodable {
    let key: String
    var url: String {
        return "https://www.youtube.com/watch?v=\(self.key)"
    }
}
