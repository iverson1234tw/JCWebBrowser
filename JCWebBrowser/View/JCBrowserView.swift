//
//  JCBrowserView.swift
//  JCWebBrowser
//
//  Created by hungwei on 2021/8/26.
//

import UIKit
import WebKit

class JCBrowserView: UIView, WKNavigationDelegate {        

    // webView declare
    var webView: WKWebView!
    
    // progressView declare
    var progressView: UIProgressView!
    
    // bottomToolBar declare
    var jcToolBar: JCToolBar!
    
    // url declare
    var url: String!
    
    // MARK: - init with Frame
    
    init(frame: CGRect, url: String) {
        super.init(frame: frame)
    
        // set url
        self.url = url
        
        // configuration init
        let configuration = WKWebViewConfiguration()
        
        // configuration properties
        configuration.allowsInlineMediaPlayback = true
        
        // webView init
        webView = WKWebView(frame: .zero, configuration: configuration)
        
        // webView properties
        webView.isOpaque = false
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.load(URLRequest(url: URL(string: url)!))
        
        addSubview(webView)
        
        // progressView init
        progressView = UIProgressView(progressViewStyle: .bar)
        
        webView.addSubview(progressView)
        
        // jcToolBar init
        jcToolBar = JCToolBar(frame: .zero)                
        
        addSubview(jcToolBar)
        
    }
    
    // MARK: - layoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // jcToolBar constraints
        jcToolBar.snp.makeConstraints { (maker) in
            maker.left.bottom.right.equalToSuperview()
            if UIDevice.current.hasNotch {
                maker.height.equalTo(80)
            } else {
                maker.height.equalTo(60)
            }
        }
        
        // webView constraints
        webView.snp.makeConstraints { (maker) in
            maker.left.top.right.equalToSuperview()
            maker.bottom.equalTo(jcToolBar)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }        
    
}

// MARK: - UIDevice extension

extension UIDevice {
    
    // if has notch
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
}
