//
//  MainTabBarViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeMainViewController = HomeMainViewController()
        let companyAnalysisMainViewController = CompanyAnalysisMainViewController()
        let tradingLogMainViewController = TradingLogMainViewController()
        let bookmarkMainViewController = BookmarkMainViewController()
        let moreMainViewController = MoreMainViewController()
        
        setViewControllers([homeMainViewController,
                            companyAnalysisMainViewController,
                            tradingLogMainViewController,
                            bookmarkMainViewController,
                            moreMainViewController],
                           animated: false)
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
    }
}
