//
//  MoreMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class MoreMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = .blue
        tabBarItem = UITabBarItem(title: "더보기", image: UIImage(named: "icBarAdd"), selectedImage: UIImage(named: "icBarAddSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
