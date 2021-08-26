//
//  JCToolBar.swift
//  JCWebBrowser
//
//  Created by hungwei on 2021/8/26.
//

import UIKit

class JCToolBar: UIView {

    // toolBarSeparator init
    let toolBarSeparator = UILabel()
    
    // backButton init
    let backButton = UIButton(frame: .zero)
    
    // reloadButton init
    let reloadButton = UIButton(frame: .zero)
    
    // forwardButton init
    let forwardButton = UIButton(frame: .zero)
    
    // shareButton init
    let shareButton = UIButton(frame: .zero)
    
    // MARK: - init with Frame
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set backgroundColor
        backgroundColor = .white
        
        // toolBarSeparator properties
        toolBarSeparator.backgroundColor = .lightGray
        
        addSubview(toolBarSeparator)
        
        // backButton properties
        backButton.setImage(UIImage(named: "left_arrow_disable"), for: .normal)
        
        addSubview(backButton)
        
        // reloadButton properties
        reloadButton.setImage(UIImage(named: "reload_disable"), for: .normal)
        
        addSubview(reloadButton)
        
        // forwardButton properties
        forwardButton.setImage(UIImage(named: "right_arrow_disable"), for: .normal)
        
        addSubview(forwardButton)
        
        // shareButton properties
        shareButton.setImage(UIImage(named: "share_disable"), for: .normal)
        
        addSubview(shareButton)
        
    }
    
    // MARK: - layoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // toolBarSeparator constraints
        toolBarSeparator.snp.makeConstraints { (maker) in
            maker.left.top.right.equalToSuperview()
            maker.height.equalTo(0.25)
        }
        
        // backButton constraints
        backButton.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(15)
            maker.left.equalToSuperview().offset(15)
            maker.width.height.equalTo(30)
        }
        
        // reloadButton constraints
        reloadButton.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(backButton)
            maker.width.height.equalTo(20)
            maker.left.equalTo(backButton.snp.right).offset(40)
        }
        
        // forwardButton constraints
        forwardButton.snp.makeConstraints { (maker) in
            maker.centerY.width.height.equalTo(backButton)
            maker.left.equalTo(reloadButton.snp.right).offset(40)
        }
        
        // shareButton constraints
        shareButton.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(backButton)
            maker.width.height.equalTo(40)
            maker.right.equalToSuperview().offset(-15)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
