//
//  MoreMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class MoreMainViewController: UIViewController {

    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "더보기"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 20)
    }
    
    let nameLabel = UILabel().then {
        $0.text = "김쉐어"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 18)
    }
    
    let detailButton = UIButton().then {
        $0.setImage(UIImage(named: "iconsMidDetail"), for: .normal)
    }
    
    let moveHiveContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.applySketchShadow(color: .black1, alpha: 0.1, x: 0, y: 2, blur: 5, spread: 0)
    }
    
    let hiveIconImageView = UIImageView().then {
//        $0.image = UIImage(named: "hive")
        $0.backgroundColor = .green
    }
    
    let hiveLabel = UILabel().then {
        $0.text = "벌집 확인하기"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let hiveMoveButton = UIButton().then {
        $0.setImage(UIImage(named: "iconsFold"), for: .normal)
    }
    
    // MARK: Methods
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "더보기", image: UIImage(named: "icBarAdd"), selectedImage: UIImage(named: "icBarAddSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        
        view.addSubview(nameLabel)
        view.addSubview(detailButton)
        
        view.addSubview(moveHiveContainerView)
        moveHiveContainerView.addSubview(hiveIconImageView)
        moveHiveContainerView.addSubview(hiveLabel)
        moveHiveContainerView.addSubview(hiveMoveButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(31)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        detailButton.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right)
            make.centerY.equalTo(nameLabel)
            make.width.height.equalTo(20)
        }
        
        moveHiveContainerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(23)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(45)
        }
        
        hiveIconImageView.snp.makeConstraints { make in
            make.left.equalTo(moveHiveContainerView).offset(10)
            make.centerY.equalTo(moveHiveContainerView)
            make.width.height.equalTo(30)
        }
        
        hiveLabel.snp.makeConstraints { make in
            make.left.equalTo(hiveIconImageView.snp.right).offset(5)
            make.centerY.equalTo(moveHiveContainerView)
        }
        
        hiveMoveButton.snp.makeConstraints { make in
            make.right.equalTo(moveHiveContainerView).offset(-5)
            make.centerY.equalTo(moveHiveContainerView)
            make.width.height.equalTo(30)
        }
        
        super.updateViewConstraints()
    }
}
