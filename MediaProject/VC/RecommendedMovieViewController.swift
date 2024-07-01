//
//  RecommendedMovieViewController.swift
//  MediaProject
//
//  Created by 박성민 on 6/24/24.
//

import UIKit

import SnapKit
// MARK: - 영화 담는 구조체
struct MovieData {
    let id: Int
    let imageList: String
}

final class RecommendedMovieViewController: UIViewController {
    private lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(SameMovieTableViewCell.self, forCellReuseIdentifier: SameMovieTableViewCell.id)
        return view
    }()
    lazy var movieid = 0
    lazy var navTitle = ""
    private var movieList: [[MovieData]] = [[],[],[]]
    let titleList = ["비슷한 영화", "추천 영화", "포스터"]
    
    let network = MovieNetwork.shard
    let urlSessionNetwork = MovieNetworkURLSession.shard
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movieid)
        setUpHierarch()
        setUpLayout()
        setUpUI()
        setUpCollection()
        callNetwork()
        
    }
    func callNetwork() {
        let group = DispatchGroup()
        //1
        group.enter()
        DispatchQueue.global().async {
            print("1")
            self.urlSessionNetwork.callRequest(id: self.movieid, movieEnum: .sameMovie, decodeType: RecommendMovieModel.self) { data, error in
                if let error = error {
                    print(error)
                    group.leave()
                }else{
                    if let data = data {
                        data.results.forEach { image in
                            let movie = MovieData(id: image.id, imageList: image.poster_path)
                            self.movieList[0].append(movie)
                            
                        }
                        group.leave()

                    }
                    
                }
                
            }
            //group.leave()
            //            self.network.callMovieRequset(movieId: self.movieid, movieEnum: .sameMovie,decodeType: RecommendMovieModel.self) { data,error in
            //                if let error = error {
            //                    print(error)
            //                }else{
            //                    if let data = data {
            //                        data.results.forEach { i in
            //                            self.imageList[0].append(i.poster_path)
            //                        }
            //                    }
            //                    group.leave()
            //                }
            //            }
        }
        
        
        //2
        group.enter()
        DispatchQueue.global().async {
            self.network.callMovieRequset(movieId: self.movieid, movieEnum: .recommendMovie, decodeType: RecommendMovieModel.self) { data,error in
                if let error = error {
                    print(error)
                    group.leave()

                }else{
                    if let data = data {
                        data.results.forEach { image in
                            let movie = MovieData(id: image.id, imageList: image.poster_path)
                            self.movieList[1].append(movie)
                            
                        }
                        group.leave()

                    }


                }
            }
        }
        //3
        group.enter()
        DispatchQueue.global().async {
            
            self.network.callMovieRequset(movieId: self.movieid, movieEnum: .poster,decodeType: PostModel.self) { data, error in
                if let error = error {
                    print(error)
                    group.leave()

                }else{
                    if let data = data {
                        data.posters.forEach { image in
                            let movie = MovieData(id: self.movieid, imageList: image.file_path)
                            self.movieList[2].append(movie)
                            
                        }
                        group.leave()

                    }

                }
            }
        }
        
        group.notify(queue: .main){
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - connect 부분
    func setUpHierarch() {
        view.addSubview(tableView)
        
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        navigationItem.title = navTitle
        
        view.backgroundColor = .white
        
    }
    func setUpCollection() {
    }
    // MARK: - 동적 UI 세팅 부분
    func setUpDynamicUI() {
        
    }
    
}
extension RecommendedMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SameMovieTableViewCell.id, for: indexPath) as! SameMovieTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(SameMovieCollectionViewCell.self, forCellWithReuseIdentifier: SameMovieCollectionViewCell.id)
        cell.setTitle(titleList[indexPath.row])
        cell.collectionView.reloadData()
        return cell
    }
    
    
}
extension RecommendedMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SameMovieCollectionViewCell.id, for: indexPath) as! SameMovieCollectionViewCell
        let data = movieList[collectionView.tag][indexPath.item]
        cell.setUpData(data.imageList)
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VideoViewController()
        vc.id = movieList[collectionView.tag][indexPath.item].id
        print(vc.id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
