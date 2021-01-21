//
//  TradingLogMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import Then
import UIKit

class TradingLogMainViewController: UIViewController {
    
    let titleLabel = UILabel().then {
        $0.text = "매매일지"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "매매일지", image: UIImage(named: "icBarWrite"), selectedImage: UIImage(named: "icBarWriteSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
        }
        
        super.updateViewConstraints()
    }
}
