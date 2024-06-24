//
//  MovieTableViewCell.swift
//  MediaProject
//
//  Created by 박성민 on 6/10/24.
//

import UIKit

import SnapKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    let dateLabel = UILabel()
    
    let mainImage = UIImageView()
    let voteString = UILabel()
    let voteNum = UILabel()
    
    let mainTitle = UILabel()
    let overviewTitle = UILabel()
    let line = UIView()
    
    let selectLabel = UILabel()
    let selectImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpHierarch()
        setUpLayout()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - connect 부분
    func setUpHierarch() {
        contentView.addSubview(dateLabel)
        
        contentView.addSubview(mainImage)
        mainImage.addSubview(voteString)
        mainImage.addSubview(voteNum)
        
        contentView.addSubview(mainTitle)
        contentView.addSubview(overviewTitle)
        contentView.addSubview(line)
        
        contentView.addSubview(selectLabel)
        contentView.addSubview(selectImage)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(20)
        }
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(360)
        }
        voteString.snp.makeConstraints { make in
            make.leading.equalTo(mainImage.snp.leading).offset(20)
            make.bottom.equalTo(mainImage.snp.bottom).offset(-20)
            make.trailing.equalTo(voteNum.snp.leading)
            make.size.equalTo(40)
        }
        voteNum.snp.makeConstraints { make in
            make.bottom.equalTo(mainImage.snp.bottom).offset(-20)
            make.size.equalTo(40)
        }
        mainTitle.snp.makeConstraints { make in
            make.leading.equalTo(mainImage.snp.leading).offset(10)
            make.top.equalTo(mainImage.snp.bottom).offset(15)
            make.height.equalTo(35)
        }
        overviewTitle.snp.makeConstraints { make in
            make.leading.equalTo(mainImage.snp.leading).offset(10)
            make.top.equalTo(mainTitle.snp.bottom).offset(5)
            make.trailing.equalTo(mainImage.snp.trailing).offset(-10)
            make.height.equalTo(25)
        }
        line.snp.makeConstraints { make in
            make.leading.equalTo(mainImage.snp.leading).offset(10)
            make.trailing.equalTo(mainImage.snp.trailing).offset(-10)
            make.top.equalTo(overviewTitle.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        selectLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImage.snp.leading).offset(10)
            make.top.equalTo(line.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        selectImage.snp.makeConstraints { make in
            make.trailing.equalTo(mainImage.snp.trailing).inset(10)
            make.top.equalTo(line.snp.bottom).offset(10)
            make.size.equalTo(25)
        }
    }
    
    // MARK: - UI 세팅 부분 (정적)
    func setUpUI() {
        dateLabel.font = .systemFont(ofSize: 15)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .left
        
        mainImage.contentMode = .scaleToFill
        mainImage.clipsToBounds = true
        mainImage.layer.cornerRadius = 10
        
        voteString.text = "평점"
        voteString.font = .systemFont(ofSize: 17)
        voteString.textColor = .white
        voteString.textAlignment = .center
        voteString.backgroundColor = .purple
        
        voteNum.font = .systemFont(ofSize: 17)
        voteNum.textColor = .black
        voteNum.textAlignment = .center
        voteNum.backgroundColor = .white
        
        mainTitle.font = .boldSystemFont(ofSize: 23)
        mainTitle.textColor = .black
        mainTitle.textAlignment = .left
        mainTitle.numberOfLines = 1
        
        overviewTitle.font = .systemFont(ofSize: 20)
        overviewTitle.textColor = .black
        overviewTitle.textAlignment = .left
        overviewTitle.numberOfLines = 1
        
        line.backgroundColor = .black
        
        selectLabel.text = "자세히 보기"
        selectLabel.font = .systemFont(ofSize: 17)
        selectLabel.textAlignment = .left
        selectLabel.textColor = .black
        
        selectImage.image = UIImage(systemName: "greaterthan")
        selectImage.tintColor = .black
        
    }
    
    // MARK: - 동적인 세팅 부분
    func setUpData(data: Movie) {
        dateLabel.text = data.release_date
        
        
    //http://image.tmdb.org/t/p/w500/nv6F6tz7r61DUhE7zgHwLJFcTYp.jpg
        let url = URL(string: "http://image.tmdb.org/t/p/w500\(data.poster_path)")!
        //print(url)
        //http://image.tmdb.org/t/p/w500/sh7Rg8Er3tFcN9BpKIPOMvALgZd.jpg
        mainImage.kf.setImage(with: url)
        //mainImage.image = UIImage(data: <#T##Data#>)
        //mainImage.image = UIImage(systemName: "heart")
        voteNum.text = String(format: "%.1f", data.vote_average)
        
        mainTitle.text = data.title
        
        overviewTitle.text = data.overview
        
        
    }

}
