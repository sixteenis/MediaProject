//
//  ErrorView+.swift
//  MediaProject
//
//  Created by 박성민 on 7/1/24.
//

import UIKit

class ErrorView: UIView {
    let mainImage = UIImageView()
    let mainTitle = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
