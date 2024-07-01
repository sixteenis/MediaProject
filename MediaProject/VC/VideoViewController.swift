//
//  VideoViewController.swift
//  MediaProject
//
//  Created by 박성민 on 7/1/24.
//

import UIKit
import WebKit

import SnapKit
final class VideoViewController: UIViewController {
    let webView = WKWebView()
    var id: Int?
    let network = MovieNetwork.shard
    var url: String?
    let errorImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpHierarch()
        setUpLayout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let id = id else { return }
        network.callYoutubeRequset(movieId: id, movieEnum: .video, decodeType: VideoModel.self) { data, error in
            if error != nil {
                print("에러")
                
            }else{
                if data!.results.isEmpty{
                    print("없음")
                }else{
                    self.url = data?.results[0].url
                }
            }
            guard let url = self.url else {return }
            self.setUpUI(youtube: url)
        }
        
    }
    
    // MARK: - connect 부분
    func setUpHierarch() {
        view.addSubview(webView)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI(youtube: String) {
        let url = URL(string: youtube)!
        let myrequest = URLRequest(url: url)
        webView.load(myrequest)
    }
    // MARK: - 동적 UI 세팅 부분
    func setUpDynamicUI() {
        
    }

}
extension VideoViewController: WKNavigationDelegate {
    
}
