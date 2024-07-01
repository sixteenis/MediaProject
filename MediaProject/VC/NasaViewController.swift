//
//  NasaViewController.swift
//  MediaProject
//
//  Created by 박성민 on 7/1/24.
//

import UIKit
import SnapKit
import Then
import Alamofire

class NasaViewController: UIViewController {
    let button = UIButton().then {
        $0.setTitle("이미지 다운 시 클릭!", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
    }
    let hideButton = UIView().then {
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    let label = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = "이미지 다운 진행중~~~~"
    }
    let imageView = UIImageView().then {
        $0.backgroundColor = .white
    }
    let loadingView = UIImageView().then {
        $0.backgroundColor = .systemGreen
    }
    var session: URLSession!
    var total:Double = 0
    var loadingHeight: Constraint?
    var buffer: Data? {
        didSet {
            
            guard total != 0.0 else {return}
            guard let buffer = buffer else {return}
            let result = Double(buffer.count) / total
            print(self.imageView.frame.height)
            print(result)
            print("--------")
            loadingHeight?.update(offset: Int(Double(self.imageView.frame.height)*result))
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.invalidateAndCancel() // 중단하는 명령어
    }
    
    // MARK: - connect 부분
    func setUpHierarch() {
        view.addSubview(button)
        view.addSubview(hideButton)
        view.addSubview(imageView)
        view.addSubview(loadingView)
        hideButton.addSubview(label)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        button.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        hideButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        loadingView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            loadingHeight = make.height.equalTo(0).constraint
        }
        label.snp.makeConstraints { make in
            make.center.equalTo(hideButton)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    // MARK: - 동적 UI 세팅 부분
    func setUpDynamicUI() {
        
    }
    func callrequest() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2406/AraDragons_Taylor_4728.jpg")!
        let request = URLRequest(url: url)
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        session.dataTask(with: request).resume()
    }
    @objc func buttonTapped() {
        print(#function)
        buffer = Data()
        callrequest()
        imageView.image = nil
        loadingView.isHidden = false
        hideButton.isHidden = false
    }
}



extension NasaViewController: URLSessionDataDelegate {
    // 서버에서 최초로 응답 받은 경우에 호출 (ex: 상태코드)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            self.total = Double(contentLength)!
            return .allow
        }else {
            return .cancel
        }
        
    }
    // 서버에서 데이터를 받아올 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(#function,data)
        buffer?.append(data)
        
    }
    // 응답이 완료 될 때 호출됨
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error {
            print(error)
        } else{
            guard let buffer = buffer else {
                print("Buffer nil")
                return
            }
            let image = UIImage(data: buffer)
            imageView.image = image
        }
        loadingHeight?.update(offset: 0)
        hideButton.isHidden = true
        loadingView.isHidden = true
    }
}
