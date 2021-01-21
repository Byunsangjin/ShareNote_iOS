//
//  BookmarkMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class BookmarkMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = .green
        tabBarItem = UITabBarItem(title: "쉐어킵", image: UIImage(named: "icBarSharekeep"), selectedImage: UIImage(named: "icBarSharekeepSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
