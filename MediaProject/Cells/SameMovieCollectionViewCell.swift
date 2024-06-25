//
//  SameMovieCollectionViewCell.swift
//  MediaProject
//
//  Created by 박성민 on 6/24/24.
//

import UIKit
import Kingfisher

class SameMovieCollectionViewCell: UICollectionViewCell {
    let postImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarch()
        setUpLayout()
        setUpUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: - connect 부분
    func setUpHierarch() {
        contentView.addSubview(postImage)
    }
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        postImage.layer.cornerRadius = 15
    }
    // MARK: - Layout 부분
    func setUpLayout() {
        postImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UI 세팅 부분 (정적)
    func setUpUI() {
        postImage.clipsToBounds = true
        postImage.contentMode = .scaleAspectFill
    }
    
    // MARK: - 동적인 세팅 부분
    func setUpData(_ image: String) {
        let url = URL(string: "http://image.tmdb.org/t/p/w500\(image)")!
        postImage.kf.setImage(with: url)
    }
}
