//
//  AppVersionViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/10.
//

import RxSwift
import UIKit

class AppVersionViewController: UIViewController {
    
    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "버전정보"
    }
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logoSharenote")
    }
    
    let versionLabel = UILabel().then {
        $0.text = "V.01\n최신 버전입니다."
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        navigationView.leftBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(logoImageView)
        view.addSubview(versionLabel)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(60)
            make.centerX.equalTo(view)
            make.width.height.equalTo(85)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
}
