//
//  CompanyAnalysisMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class CompanyAnalysisMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = .orange
        tabBarItem = UITabBarItem(title: "기업분석", image: UIImage(named: "icBarAnalysis"), selectedImage: UIImage(named: "icBarAnalysisSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
