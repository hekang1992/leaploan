//
//  H5WebViewController.swift
//  leaploan
//
//  Created by hekang on 2025/11/5.
//

import UIKit
import WebKit
import RxSwift
import StoreKit
import SnapKit
import RxCocoa

class H5WebViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    var pageUrl: String?
    var productID: String = ""
    
    private lazy var webView = makeWebView()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(hexString: "#FF29D5")
        progressView.trackTintColor = .lightGray
        return progressView
    }()
    
    var json: [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebContent()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hexString: "#1ABFFF")
        view.addSubview(headView)
        view.addSubview(progressView)
        view.addSubview(webView)
        setupConstraints()
        
        headView.clickBlock = { [weak self] in
            self?.popAuthListVC()
        }
    }
    
    private func setupConstraints() {
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(40)
        }
        
        progressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
            make.height.equalTo(2)
        }
        
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom)
        }
    }
    
    private func makeWebView() -> WKWebView {
        let configuration = WKWebViewConfiguration()
        addScriptMessageHandlers(to: configuration)
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        return webView
    }
    
    private func addScriptMessageHandlers(to configuration: WKWebViewConfiguration) {
        let scriptNames = ["Chappells", "deploys", "akenes", "mazaedia", "matroclinal", "metrication", "Braque"]
        scriptNames.forEach { configuration.userContentController.add(self, name: $0) }
    }
    
    private func loadWebContent() {
        guard let pageUrl = pageUrl,
              let apiUrl = ParameterToUrlConfig.appendQuery(to: pageUrl, parameters: commonPara.loginDictInfo()),
              let encodedUrlString = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrlString) else {
            print("Invalid URL")
            return
        }
        
        webView.load(URLRequest(url: url))
        print("Loaded URL: \(url.absoluteString)")
        bindWebViewObservers()
    }
    
    private func bindWebViewObservers() {
        webView.rx.observe(String.self, "title")
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .bind(to: headView.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] progress in
                guard let self = self else { return }
                self.progressView.isHidden = progress >= 1.0
                self.progressView.setProgress(Float(progress), animated: true)
            }).disposed(by: disposeBag)
    }
}

extension H5WebViewController: WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        print("Received message: \(message.name) - \(message.body)")
        switch message.name {
        case "matroclinal":
            /// GO_POING_INFO
            
            break
        case "Braque":
            /// END_BIND_CARD
            json?["end"] = String(Int(Date().timeIntervalSince1970))
            break
        case "Chappells":
            /// CLOSE_WEB_VIEW
            self.popAuthListVC()
            break
        case "akenes":
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                NotificationCenter.default.post(name: CHANGE_ROOT_VC, object: nil)
            }
            break
        case "mazaedia":
            /// APP_STAR_MESSAGE
            appStarInfo()
            break
        case "deploys":
            break
        case "metrication":
            /// START_BIND_CARD
            json?["start"] = String(Int(Date().timeIntervalSince1970))
            break
        default:
            break
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("WebView started loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView failed with error: \(error.localizedDescription)")
    }
}

extension H5WebViewController {
    
    private func appStarInfo() {
        guard #available(iOS 14.0, *) else { return }
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        
        SKStoreReviewController.requestReview(in: windowScene)
    }
    
}
