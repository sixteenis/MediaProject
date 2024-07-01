//
//  MainViewController.swift
//  MediaProject
//
//  Created by 박성민 on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit

final class MainViewController: UIViewController {
    let movieTableView = UITableView()
    
    var movieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
        setUpTableView()
        callRequest()
    }
    
    // MARK: - connect 부분
    func setUpHierarch() {
        let item = UIBarButtonItem(image: UIImage(systemName: "plus"),style: .plain,  target: self, action: #selector(nvButtonTapped))
        navigationItem.rightBarButtonItem = item
        
        view.addSubview(movieTableView)
    }
    @objc func nvButtonTapped() {
        let vc = NasaViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Layout 부분
    func setUpLayout() {
        movieTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        view.backgroundColor = .white
        navigationItem.title = "영화 순위"
        
        movieTableView.backgroundColor = .white
    }
    func setUpTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.id)
        movieTableView.rowHeight = 560
        movieTableView.separatorStyle = .none
    }
    // MARK: - 네트워크 통신 부분
    func callRequest() {
        AF.request(APIKey.TMDBWeekAPI).responseDecodable(of: WeekMovieModel.self) { respons in
            switch respons.result{
            case .success(let data):
                self.succesNetworkAndSetView(movies: data)
            case .failure(let error):
                dump(error)
                
            }
        }
    }
    
    func succesNetworkAndSetView(movies: WeekMovieModel) {
        self.movieList = movies.results
        movieTableView.reloadData()
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.id, for: indexPath) as! MovieTableViewCell
        let data = movieList[indexPath.row]
        cell.setUpData(data: data)
        return cell
    }
    // MARK: - 추천 뷰로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RecommendedMovieViewController()
        vc.movieid = movieList[indexPath.row].id
        vc.navTitle = movieList[indexPath.row].title
        print(movieList[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
