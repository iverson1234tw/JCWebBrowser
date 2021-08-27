//
//  JCBrowserView.swift
//  JCWebBrowser
//
//  Created by hungwei on 2021/8/26.
//

import UIKit
import WebKit

class JCBrowserView: UIView {

    // webView declare
    var webView: WKWebView!
    
    // progressView declare
    var progressView: UIProgressView!
    
    // bottomToolBar declare
    var jcToolBar: JCToolBar!
    
    // progress init (default is 0)
    var progress: Float = 0.0 {
        didSet {
            // set progressBar
            progressView.progress = progress
            // handle progressView showing
            progressView.isHidden = progress == 1.0 ? true : false
        }
    }
    
    // can share the link (default is false)
    var canShare: Bool = false {
        didSet {
            // shareButton's hidden depends on canShare value
            jcToolBar.shareButton.isHidden = canShare ? false : true
        }
    }
    
    // link to the website
    var url: String!
    
    // MARK: - init with Frame
    
    init(frame: CGRect, url: String) {
        super.init(frame: frame)
    
        // set url link
        self.url = url
        
        // configuration init
        let configuration = WKWebViewConfiguration()
        
        // configuration properties
        configuration.allowsInlineMediaPlayback = true
        
        // webView init
        webView = WKWebView(frame: .zero, configuration: configuration)
        
        // webView properties
        webView.isOpaque = false
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
    
    // MARK: - toolBarButtonStatus with isLoading status
    
    public func toolBarButtonStatus(isLoading: Bool) {
        
        // switch by isLoading
        switch isLoading {
        case true:
            // reloadButton properties
            jcToolBar.reloadButton.isUserInteractionEnabled = false
            
            // reloadButton set image
            jcToolBar.reloadButton.setImage(UIImage(named: "reload_disable"), for: .normal)
            
            // shareButton properties
            jcToolBar.shareButton.isUserInteractionEnabled = false
            
            // shareButton set image
            jcToolBar.shareButton.setImage(UIImage(named: "share_disable"), for: .normal)
            
        default:
            // reloadButton properties
            jcToolBar.reloadButton.isUserInteractionEnabled = true
            
            // reloadButton set image
            jcToolBar.reloadButton.setImage(UIImage(named: "reload"), for: .normal)
            
            // shareButton properties
            jcToolBar.shareButton.isUserInteractionEnabled = true
            
            // shareButton set image
            jcToolBar.shareButton.setImage(UIImage(named: "share"), for: .normal)
            
            // previousButton set image
            jcToolBar.backButton.setImage(webView.canGoBack ? UIImage(named: "left_arrow") : UIImage(named: "left_arrow_disable"), for: .normal)
            
            // nextButton set image
            jcToolBar.forwardButton.setImage(webView.canGoForward ? UIImage(named: "right_arrow") : UIImage(named: "right_arrow_disable"), for: .normal)
            
        }
        
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
