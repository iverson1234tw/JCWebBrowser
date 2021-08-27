//
//  JCBrowserController.swift
//  JCWebBrowser
//
//  Created by hungwei on 2021/8/26.
//

import UIKit
import WebKit
import JGProgressHUD

class JCBrowserController: UIViewController, WKNavigationDelegate {
    
    // hud init
    let hud = JGProgressHUD()
    
    // MARK: - didStartProvisionalNavigation (WKWebView)
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
                        
        // hud start loading
        hud.show(in: view, animated: true)
        
        // handle toolBar buttons status
        jcBrowserView.toolBarButtonStatus(isLoading: webView.isLoading)
        
    }
    
    // MARK: - didFinish (WKWebView)
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // dismiss hud
        hud.dismiss(animated: true)
        
        // handle toolBar buttons status
        jcBrowserView.toolBarButtonStatus(isLoading: webView.isLoading)
        
    }
    
    // jcBrowserView declare
    var jcBrowserView: JCBrowserView!
            
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // jcBrowserView init
        jcBrowserView = JCBrowserView(frame: .zero, url: "https://www.facebook.com/OBdesign.tw/videos/3057903817778160/")
        
        // jcBrowserView delegate
        jcBrowserView.webView.navigationDelegate = self
        
        // webView add observer
        jcBrowserView.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        jcBrowserView.webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        // toolBar button addTarget
        jcBrowserView.jcToolBar.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        jcBrowserView.jcToolBar.reloadButton.addTarget(self, action: #selector(reloadButtonClicked), for: .touchUpInside)
        jcBrowserView.jcToolBar.forwardButton.addTarget(self, action: #selector(forwardButtonClicked), for: .touchUpInside)
//        jcBrowserView.jcToolBar.shareButton.addTarget(self, action: #selector(shareButtonClicked), for: .touchUpInside)
        
        view.addSubview(jcBrowserView)

    }
    
    // MARK: - viewWillLayoutSubviews
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // jcBrowserView constraints
        jcBrowserView.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        
    }
    
    // MARK: - backButtonClicked
    
    @objc func backButtonClicked() {
        
        // if browser can go back
        if jcBrowserView.webView.canGoBack {
            jcBrowserView.webView.goBack()
        }
        
    }
    
    // MARK: - reloadButtonClicked
    
    @objc func reloadButtonClicked() {
        
        // if is not loading
        if !jcBrowserView.webView.isLoading {
            jcBrowserView.webView.reload()
        }
        
    }
    
    // MARK: - forwardButtonClicked
    
    @objc func forwardButtonClicked() {
        
        // if browser can go forward
        if jcBrowserView.webView.canGoForward {
            jcBrowserView.webView.goForward()
        }
        
    }
    
    // FIXME: - shareButton Clicked
    
//    @objc func shareButtonClicked() {
//
//        // item init
//        let item: [Any] = ["\(jcBrowserView.webView.title!)\n\n\(jcBrowserView.webView.url!)"]
//
//        // activity init
//        let activity = UIActivityViewController(activityItems: item, applicationActivities: nil)
//
//        // present activity
//        present(activity, animated: true, completion: nil)
//
//    }

    // MARK: - observeValue (KVO)
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // keyPath for progressBar listener
        if keyPath == "estimatedProgress" {
            
            // set current progress
            jcBrowserView.progress = Float(jcBrowserView.webView.estimatedProgress);
            
        }
        
        // keyPath for title listener
        else if keyPath == "title" {
            
            // set title for webView
            if object as? NSObject == jcBrowserView.webView {
                self.navigationController?.navigationBar.topItem?.title = jcBrowserView.webView.title
            } else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
            
        }
        
    }

}
