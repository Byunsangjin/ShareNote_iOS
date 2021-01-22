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
    
    let viewHoneyPageButton = UIButton().then {
        $0.setImage(UIImage(named: "icMyHoneyPage"), for: .normal)
        $0.setImage(UIImage(named: "icMyHoneyPage"), for: .highlighted)
    }
    
    let editButton = UIButton().then {
        $0.setImage(UIImage(named: "icEdit"), for: .normal)
        $0.setImage(UIImage(named: "icEdit"), for: .highlighted)
        
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
        view.addSubview(viewHoneyPageButton)
        view.addSubview(editButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
        }
        
        viewHoneyPageButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
        
        super.updateViewConstraints()
    }
}
