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
        
        let companyAnalysisMainNavigationController = UINavigationController(rootViewController: CompanyAnalysisMainViewController())
        companyAnalysisMainNavigationController.isNavigationBarHidden = true
        
        let tradingLogMainViewController = TradingLogMainViewController()
        
        let bookmarkMainViewController = BookmarkMainViewController()
        
        let moreMainNavigationController = UINavigationController(rootViewController: MoreMainViewController())
        moreMainNavigationController.isNavigationBarHidden = true
        
        setViewControllers([homeMainViewController,
                            companyAnalysisMainNavigationController,
                            tradingLogMainViewController,
                            bookmarkMainViewController,
                            moreMainNavigationController],
                           animated: false)
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
    }
}
