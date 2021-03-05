//
//  MoreMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class MoreMainViewController: UIViewController {
    
    // MARK: Constants
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView().then {
        $0.backgroundColor = .white
    }
    
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
        $0.image = UIImage(named: "iconHoney")
    }
    
    let hiveLabel = UILabel().then {
        $0.text = "벌집 확인하기"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let hiveMoveButton = UIButton().then {
        $0.setImage(UIImage(named: "iconsFold"), for: .normal)
    }
    
    let serviceCenterButton = UIButton().then {
        $0.setImage(UIImage(named: "icPlus1Service"), for: .normal)
    }
    
    let serviceCenterLabel = UILabel().then {
        $0.text = "고객센터"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let noticeButton = UIButton().then {
        $0.setImage(UIImage(named: "icPlus2Notice"), for: .normal)
    }
    
    let noticeLabel = UILabel().then {
        $0.text = "공지사항"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let eventButton = UIButton().then {
        $0.setImage(UIImage(named: "icPlus3Event"), for: .normal)
    }
    
    let eventLabel = UILabel().then {
        $0.text = "이벤트"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let testView = UIView().then {
        $0.backgroundColor = .yellow
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(titleLabel)
        
        scrollContentView.addSubview(nameLabel)
        scrollContentView.addSubview(detailButton)
        
        scrollContentView.addSubview(moveHiveContainerView)
        moveHiveContainerView.addSubview(hiveIconImageView)
        moveHiveContainerView.addSubview(hiveLabel)
        moveHiveContainerView.addSubview(hiveMoveButton)
        
        scrollContentView.addSubview(serviceCenterButton)
        scrollContentView.addSubview(serviceCenterLabel)
        scrollContentView.addSubview(noticeButton)
        scrollContentView.addSubview(noticeLabel)
        scrollContentView.addSubview(eventButton)
        scrollContentView.addSubview(eventLabel)
        
        scrollContentView.addSubview(testView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.bottom.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.width.equalTo(scrollView)
            make.height.equalTo(757)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(60)
            make.left.equalTo(scrollContentView).offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(31)
            make.left.equalTo(scrollContentView).offset(20)
        }
        
        detailButton.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right)
            make.centerY.equalTo(nameLabel)
            make.width.height.equalTo(20)
        }
        
        moveHiveContainerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(23)
            make.centerX.equalTo(scrollContentView)
            make.width.equalTo(scrollContentView).offset(-40)
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
        
        serviceCenterButton.snp.makeConstraints { make in
            make.top.equalTo(moveHiveContainerView.snp.bottom).offset(25)
            make.left.equalTo(scrollContentView).offset(51)
            make.width.height.equalTo(50)
        }
        
        serviceCenterLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceCenterButton.snp.bottom)
            make.centerX.equalTo(serviceCenterButton)
        }
        
        noticeButton.snp.makeConstraints { make in
            make.top.equalTo(serviceCenterButton)
            make.centerX.equalTo(scrollContentView)
            make.width.height.equalTo(50)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeButton.snp.bottom)
            make.centerX.equalTo(noticeButton)
        }
        
        eventButton.snp.makeConstraints { make in
            make.top.equalTo(serviceCenterButton)
            make.right.equalTo(scrollContentView).offset(-51)
            make.width.height.equalTo(50)
        }
        
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(eventButton.snp.bottom)
            make.centerX.equalTo(eventButton)
        }
        
        super.updateViewConstraints()
    }
}
