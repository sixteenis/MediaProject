//
//  RecommendedMovieViewController.swift
//  MediaProject
//
//  Created by 박성민 on 6/24/24.
//

import UIKit

import SnapKit
class RecommendedMovieViewController: UIViewController {
    private let sameTitle = UILabel()
    private let sameCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    private let recommendTitle = UILabel()
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    private let postTitle = UILabel()
    private let postCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let height = UIScreen.main.bounds.height / 4
        layout.itemSize = CGSize(width: height/2, height: height/1.2)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    
    
    let network = MovieNetwork.shard
    lazy var sameMovieList: [RecommendMovies] = [] {
        didSet {
            sameCollectionView.reloadData()
        }
    }
    lazy var recommendMovieList: [RecommendMovies] = [] {
        didSet {
            recommendCollectionView.reloadData()
        }
    }
    lazy var postMovieList: [Posts] = [] {
        didSet {
            postCollectionView.reloadData()
        }
    }
    lazy var movieid = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
        setUpCollection()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network.callRequset(moveId: movieid, moiveFilter: .same) { movies in
            guard let result = movies else { return }
            self.sameMovieList = result
            //print(self.sameMovieList)
        }
        network.callRequset(moveId: movieid, moiveFilter: .recommend) { movies in
            guard let result = movies else { return }
            self.recommendMovieList = result
            //print(self.sameMovieList)
        }
        network.callRequsetPost(moveId: movieid, moiveFilter: .poster) { movies in
            guard let result = movies else { return }
            self.postMovieList = result
        }
    }
    
    // MARK: - connect 부분
    func setUpHierarch() {
        view.addSubview(sameTitle)
        view.addSubview(sameCollectionView)
        view.addSubview(recommendTitle)
        view.addSubview(recommendCollectionView)
        view.addSubview(postTitle)
        view.addSubview(postCollectionView)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        sameTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        sameCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sameTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
        recommendTitle.snp.makeConstraints { make in
            make.top.equalTo(sameCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
        postTitle.snp.makeConstraints { make in
            make.top.equalTo(recommendCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        postCollectionView.snp.makeConstraints { make in
            make.top.equalTo(postTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        navigationItem.title = "극한직업"
        
        view.backgroundColor = .gray
        
        sameTitle.text = "추천 영화"
        sameTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        recommendTitle.text = "비슷한 영화"
        recommendTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        postTitle.text = "포스터"
        postTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        
    }
    func setUpCollection() {
        sameCollectionView.dataSource = self
        sameCollectionView.delegate = self
        sameCollectionView.register(SameMovieCollectionViewCell.self, forCellWithReuseIdentifier: SameMovieCollectionViewCell.id)
        sameCollectionView.backgroundColor = .gray
        sameCollectionView.showsHorizontalScrollIndicator = false
        sameCollectionView.tag = 0
        
        recommendCollectionView.dataSource = self
        recommendCollectionView.delegate = self
        recommendCollectionView.register(SameMovieCollectionViewCell.self, forCellWithReuseIdentifier: SameMovieCollectionViewCell.id)
        recommendCollectionView.backgroundColor = .gray
        recommendCollectionView.showsHorizontalScrollIndicator = false
        recommendCollectionView.tag = 1
        
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
        postCollectionView.register(SameMovieCollectionViewCell.self, forCellWithReuseIdentifier: SameMovieCollectionViewCell.id)
        postCollectionView.backgroundColor = .gray
        postCollectionView.showsHorizontalScrollIndicator = false
        postCollectionView.tag = 2
    }
    // MARK: - 동적 UI 세팅 부분
    func setUpDynamicUI() {
        
    }
    
}

extension RecommendedMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return sameMovieList.count
        case 1:
            return recommendMovieList.count
        case 2:
            return postMovieList.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SameMovieCollectionViewCell.id, for: indexPath) as! SameMovieCollectionViewCell
            let data = sameMovieList[indexPath.item].poster_path
            cell.setUpData(data)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SameMovieCollectionViewCell.id, for: indexPath) as! SameMovieCollectionViewCell
            let data = recommendMovieList[indexPath.item].poster_path
            cell.setUpData(data)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SameMovieCollectionViewCell.id, for: indexPath) as! SameMovieCollectionViewCell
            let data = postMovieList[indexPath.item].file_path
            cell.setUpData(data)
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    
    
    
}
