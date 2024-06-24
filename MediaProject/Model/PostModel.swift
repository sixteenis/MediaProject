//
//  PostModel.swift
//  MediaProject
//
//  Created by 박성민 on 6/24/24.
//

import Foundation

struct PostModel: Codable{
    let posters: [Posts]
}
struct Posts: Codable {
    let file_path: String
}
