//
//  CompanySearchViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/14.
//

import UIKit

class CompanySearchViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "기업 선택하기"
    }
    
    let searchTextField = UITextField().then {
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.textColor = .black2
        
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainColor.cgColor
        $0.layer.cornerRadius = 7
        $0.placeholder = "분석하고 싶은 기업을 검색하세요."
        
        $0.leftViewMode = .always
        let leftView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        let imageView  = UIImageView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named:"icSearch")
        leftView.addSubview(imageView)
        
        $0.leftView = leftView
    }
    
    let emptyContainerView = UIView()
    
    let emptyImageView = UIImageView().then {
        $0.image = UIImage(named: "illustSearch1")
    }
    
    let emptyLabel = UILabel().then {
        $0.text = "관심있는 기업을 검색하고\n다양한 관점에서 분석을 시작하세요"
        $0.textColor = .grey1
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(searchTextField)
        
        view.addSubview(emptyContainerView)
        emptyContainerView.addSubview(emptyImageView)
        emptyContainerView.addSubview(emptyLabel)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(25)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(45)
        }
        
        emptyContainerView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(emptyContainerView).offset(108)
            make.centerX.equalTo(emptyContainerView)
            make.width.equalTo(80.5)
            make.height.equalTo(79.4)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(32.7)
            make.centerX.equalTo(emptyContainerView)
        }
        
        super.updateViewConstraints()
    }
}
