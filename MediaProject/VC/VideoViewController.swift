//
//  VideoViewController.swift
//  MediaProject
//
//  Created by 박성민 on 7/1/24.
//

import UIKit
import WebKit

import SnapKit
class VideoViewController: UIViewController {
    let webView = WKWebView()
    var id: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
        
        
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
    func setUpUI() {
        view.backgroundColor = .white
        let url = URL(string: "https://www.youtube.com/watch?v=sMtnrdJaPHI")!
        let myrequest = URLRequest(url: url)
        webView.load(myrequest)
    }
    // MARK: - 동적 UI 세팅 부분
    func setUpDynamicUI() {
        
    }

}
extension VideoViewController: WKNavigationDelegate {
    
}
