//
//  CertificationNumberViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/17.
//

import PanModal
import UIKit

class CertificationNumberViewController: UIViewController {

    let titleLabel = UILabel().then {
        $0.text = "인증번호를 요청해주세요."
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let receiveButton = UIButton().then {
        $0.setTitle("인증번호받기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(receiveButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        receiveButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
}

extension CertificationNumberViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(185)
    }
}
