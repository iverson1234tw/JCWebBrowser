//
//  ViewController.swift
//  JCWebBrowser
//
//  Created by hungwei on 2021/8/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - heightForRowAt (UITableView)
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    // MARK: - numberOfRowsInSection (UITableView)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // MARK: - cellForRowAt (UITableView)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // CellIdentifier init
        let CellIdentifier = "Cell\(indexPath.section)\(indexPath.row)"
        
        // reuse cell init
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)

        // if cell is nil
        if cell == nil {
            
            // empty cell init
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
            
        }
        
        // cell textLabel properties
        cell?.textLabel?.text = "Facebook Live Page"
        cell?.textLabel?.font = UIFont(name: "Helvetica", size: 14.0)
        cell?.textLabel?.textColor = .darkGray
        
        return cell!
    }
    
    // MARK: - didSelectRowAt (UITableView)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // if controller is exist
        if let controller = storyboard?.instantiateViewController(withIdentifier: "JCBrowserController") as? JCBrowserController {
            
            // push to JCBrowserController
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
        
    // tableView declare
    var tableView: UITableView!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationController properties
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.topItem?.title = "OB APP"
        
        // tableView init
        tableView = UITableView(frame: .zero, style: .plain)
        
        // tableView properties
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
    }
    
    // MARK: - viewWillLayoutSubviews
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // tableView constraints
        tableView.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        
    }

}

