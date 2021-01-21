//
//  HomeMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class HomeMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .red
        tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "icBarHomeSelect"), selectedImage: UIImage(named: "icBarHomeSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
