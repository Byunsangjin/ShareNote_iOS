//
//  NavigationView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/07.
//

import UIKit
import RxSwift

class NavigationView: UIView {
    
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let leftBarButton = UIButton().then {
        $0.setImage(UIImage(named: "iconsGotobac"), for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let rightBarButton = UIButton().then {
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.addBorder([.bottom], color: .grey6, width: 1)
    }
    
    func setUI() {
        backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(leftBarButton)
        self.addSubview(rightBarButton)
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
        
        leftBarButton.snp.makeConstraints { make in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(30)
        }
        
        rightBarButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(30)
        }
        
        super.updateConstraints()
    }
}
