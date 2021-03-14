//
//  CompanyAnalysisMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import UIKit

class CompanyAnalysisMainViewController: UIViewController {
    
    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "기업분석"
        $0.leftBarButton.setImage(UIImage(named: "icMyHoneyPage"), for: .normal)
        $0.rightBarButton.setImage(UIImage(named: "icEdit"), for: .normal)
    }
    
    let emptyView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let emptyillustImage = UIImageView().then {
        $0.image = UIImage(named: "illustWrite")
    }
    
    let emptyLabel = UILabel().then {
        $0.text = "엄선된 질문으로 다양한 관점에서\n기업 분석을 시작하세요"
        $0.textColor = .grey1
        $0.font = UIFont.spoqaHanSans(size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let writeButton = UIButton().then {
        $0.setTitle("작성하기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = .grey8
        tabBarItem = UITabBarItem(title: "기업분석", image: UIImage(named: "icBarAnalysis"), selectedImage: UIImage(named: "icBarAnalysisSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        view.addSubview(navigationView)
        
        view.addSubview(emptyView)
        emptyView.addSubview(emptyillustImage)
        emptyView.addSubview(emptyLabel)
        emptyView.addSubview(writeButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyillustImage.snp.makeConstraints { make in
            make.top.equalTo(emptyView).offset(80)
            make.centerX.equalTo(emptyView)
            make.width.equalTo(103.5)
            make.height.equalTo(160)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyillustImage.snp.bottom).offset(27)
            make.centerX.equalTo(emptyillustImage)
        }
        
        writeButton.snp.makeConstraints { make in
            make.top.equalTo(emptyLabel.snp.bottom).offset(20)
            make.centerX.equalTo(emptyillustImage)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        
        super.updateViewConstraints()
    }
}
