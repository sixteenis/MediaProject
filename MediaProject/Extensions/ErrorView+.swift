//
//  ErrorView+.swift
//  MediaProject
//
//  Created by 박성민 on 7/1/24.
//

import UIKit
import SnapKit

class ErrorView: UIView {
    private let mainImage = UIImageView()
    private let mainTitle = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        self.addSubview(mainImage)
        self.addSubview(mainTitle)
        
        mainImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        mainImage.contentMode = .scaleAspectFill
        mainTitle.textAlignment = .center
        mainTitle.textColor = .black
    }
    func setUpView(text: String, image: String) {
        self.mainImage.image = UIImage(named: image)
        self.mainTitle.text = text
    }
    
    
}
