//
//  HomeMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class HomeMainViewController: UIViewController {
    
    // MARK: Constants
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView()
    
    let searchButton = UIButton().then {
        $0.setImage(UIImage(named: "icMainSearch"), for: .normal)
    }
    
    let alarmButton = UIButton().then {
        $0.setImage(UIImage(named: "icAlarm"), for: .normal)
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "icBarHome"), selectedImage: UIImage(named: "icBarHomeSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)

        scrollContentView.addSubview(searchButton)
        scrollContentView.addSubview(alarmButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.width.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.width.bottom.equalTo(scrollView)
            make.height.equalTo(1200)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(10)
            make.right.equalTo(alarmButton.snp.left).offset(-14)
            make.width.height.equalTo(30)
        }
        
        alarmButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton)
            make.right.equalTo(scrollContentView).offset(-15)
            make.width.height.equalTo(30)
        }
        
        super.updateViewConstraints()
    }
}
