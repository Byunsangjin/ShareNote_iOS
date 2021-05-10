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
    
    let summaryContainerView = UIView()
    
    let summaryBackgroundView = UIView().then {
        $0.backgroundColor = .mainColor.withAlphaComponent(0.1)
    }
    
    let illustImageView = UIImageView().then {
        $0.image = UIImage(named: "icMainIllustration")
    }
    
    let summaryLabel = UILabel().then {
        $0.text = "김쉐어님,\n첫 매매일지를 작성해보세요"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
        $0.numberOfLines = 0
    }
    
    let writeButton = UIButton().then {
        $0.setTitle("작성하러 가기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 12)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 5
    }
    
    let shareNotiPickTitleLabel = UILabel().then {
        $0.text = "쉐어노티 PICK"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 18, style: .Bold)
    }
    
    let shareNotiPickDescriptionLabel = UILabel().then {
        $0.text = "쉐어노트 이용자들의 핫 토픽들을 모았어요. 매일 업데이트되는\n주요 토픽들을 살펴보세요 !"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 12)
        $0.numberOfLines = 0
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
        
        scrollContentView.addSubview(summaryContainerView)
        summaryContainerView.addSubview(summaryBackgroundView)
        summaryBackgroundView.addSubview(illustImageView)
        summaryBackgroundView.addSubview(summaryLabel)
        summaryBackgroundView.addSubview(writeButton)
        
        scrollContentView.addSubview(shareNotiPickTitleLabel)
        scrollContentView.addSubview(shareNotiPickDescriptionLabel)
        
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
        
        summaryContainerView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(20)
            make.left.right.equalTo(scrollContentView)
            make.height.equalTo(120)
        }
        
        summaryBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(summaryContainerView).offset(12)
            make.left.equalTo(summaryContainerView).offset(18)
            make.right.equalTo(summaryContainerView).offset(-21)
            make.bottom.equalTo(summaryContainerView)
        }
        
        illustImageView.snp.makeConstraints { make in
            make.right.equalTo(summaryBackgroundView)
            make.bottom.equalTo(summaryBackgroundView).offset(-12)
            make.width.equalTo(174)
            make.height.equalTo(100)
        }
        
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(summaryBackgroundView).offset(14)
            make.left.equalTo(summaryBackgroundView).offset(21)
        }
        
        writeButton.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp.bottom).offset(7)
            make.left.equalTo(summaryLabel)
            make.width.equalTo(89)
            make.height.equalTo(30)
        }
        
        shareNotiPickTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(summaryContainerView.snp.bottom).offset(39)
            make.left.equalTo(scrollContentView).offset(20)
            make.right.equalTo(scrollContentView).offset(-20)
        }
        
        shareNotiPickDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(shareNotiPickTitleLabel.snp.bottom).offset(8)
            make.left.right.equalTo(shareNotiPickTitleLabel)
        }
        
        super.updateViewConstraints()
    }
}
