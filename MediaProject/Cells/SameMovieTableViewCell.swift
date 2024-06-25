//
//  SameMovieTableViewCell.swift
//  MediaProject
//
//  Created by 박성민 on 6/25/24.
//

import UIKit

import SnapKit

class SameMovieTableViewCell: UITableViewCell {
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 19)
        view.textColor = .black
        return view
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpHierarchy()
        setUpLayout()
        setUpUI()
    }
    
    func setUpHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    func setUpLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    func setUpUI() {
        backgroundColor = .white
        collectionView.backgroundColor = .white
    }
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
