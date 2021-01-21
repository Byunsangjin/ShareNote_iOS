//
//  TradingLogMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class TradingLogMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = .yellow
        tabBarItem = UITabBarItem(title: "매매일지", image: UIImage(named: "icBarWriteSelect"), selectedImage: UIImage(named: "icBarWriteSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
