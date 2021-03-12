//
//  CompanyAnalysisIntroViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/11.
//

import UIKit

class CompanyAnalysisIntroViewController: UIViewController {
    
    let viewStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    let stepOne = IntroView(numberOfStep: 1,
                            title: "관심있는 기업을 선택하세요",
                            description: "코스피와 코스닥에 상장된 기업의 정보를\n제공합니다")
    
    let stepTwo = IntroView(numberOfStep: 1,
                            title: "관심있는 기업을 선택하세요",
                            description: "코스피와 코스닥에 상장된 기업의 정보를\n제공합니다").then {
                                $0.isHidden = true
                            }
    
    let stepThree = IntroView(numberOfStep: 1,
                            title: "관심있는 기업을 선택하세요",
                            description: "코스피와 코스닥에 상장된 기업의 정보를\n제공합니다").then {
                                $0.isHidden = true
                            }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.transition(with: self.stepTwo, duration: 2, options: .transitionCrossDissolve) {
                self.stepTwo.isHidden = false
            } completion: { _ in
                self.view.layoutIfNeeded()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            UIView.transition(with: self.stepThree, duration: 2, options: .transitionCrossDissolve) {
                self.stepThree.isHidden = false
            } completion: { _ in
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(stepOne)
        view.addSubview(stepTwo)
        view.addSubview(stepThree)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        stepOne.snp.makeConstraints { make in
            make.top.equalTo(view).offset(145)
            make.left.equalTo(view).offset(53)
            make.height.equalTo(146)
        }
        
        stepTwo.snp.makeConstraints { make in
            make.top.equalTo(stepOne.snp.bottom)
            make.left.equalTo(stepOne)
            make.height.equalTo(146)
        }
        
        stepThree.snp.makeConstraints { make in
            make.top.equalTo(stepTwo.snp.bottom)
            make.left.equalTo(stepTwo)
            make.height.equalTo(146)
        }
        
        super.updateViewConstraints()
    }
}


