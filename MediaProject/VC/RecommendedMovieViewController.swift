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
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let height = UIScreen.main.bounds.height / 4 // 20 + 30
        layout.itemSize = CGSize(width: height/2, height: height/1.2) //셀
        layout.scrollDirection = .horizontal // 가로, 세로 스크롤 설정
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    
    
    let network = MoveNetwork.shard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
        setUpCollection()
        network.callRequset(moveId: 1022789, moiveFilter: .same)
    }
    
    // MARK: - connect 부분
    func setUpHierarch() {
        view.addSubview(sameTitle)
        view.addSubview(sameCollectionView)
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
            make.height.equalTo(120)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        navigationItem.title = "극한직업"
        
        view.backgroundColor = .white
        
        sameTitle.text = "비슷한 영화"
        sameTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        
    }
    func setUpCollection() {
        sameCollectionView.dataSource = self
        sameCollectionView.delegate = self
        sameCollectionView.register(SameMovieCollectionViewCell.self, forCellWithReuseIdentifier: SameMovieCollectionViewCell.id)
        sameCollectionView.backgroundColor = .white
        sameCollectionView.showsHorizontalScrollIndicator = false
    }
    // MARK: - 동적 UI 세팅 부분
    func setUpDynamicUI() {
        
    }

}

extension RecommendedMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SameMovieCollectionViewCell.id, for: indexPath) as! SameMovieCollectionViewCell
        
        
        return cell
    }
    
    
    
    
}
