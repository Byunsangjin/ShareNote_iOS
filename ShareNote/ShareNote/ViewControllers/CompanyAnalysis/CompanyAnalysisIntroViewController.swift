//
//  CompanyAnalysisIntroViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/11.
//

import RxSwift
import UIKit

class CompanyAnalysisIntroViewController: UIViewController {
        
    // MARK: Constants
    let stepOne = IntroView(numberOfStep: 1,
                            title: "관심있는 기업을 선택하세요",
                            description: "코스피와 코스닥에 상장된 기업의 정보를\n제공합니다").then {
                                $0.isHidden = true 
                            }
    
    let stepOneCircleButton = UIButton().then {
        $0.setImage(UIImage(named: "icCircleNotfill"), for: .normal)
        $0.setImage(UIImage(named: "icCircleFill"), for: .selected)
        $0.isHidden = true
    }
    
    let stepTwo = IntroView(numberOfStep: 2,
                            title: "엄선된 질문으로 분석을 시작하세요",
                            description: "건강한 기업을 찾기 위한 질문을 제공합니다").then {
                                $0.isHidden = true
                            }
    
    let stepTwoCircleButton = UIButton().then {
        $0.setImage(UIImage(named: "icCircleNotfill"), for: .normal)
        $0.setImage(UIImage(named: "icCircleFill"), for: .selected)
        $0.isHidden = true
    }
    
    let stepThree = IntroView(numberOfStep: 3,
                            title: "AI가 찾아주는 맞춤 서비스",
                            description: "기록이 쌓이면 쉐어님이 분석해야 할 기업을\nAI가 찾아드립니다.").then {
                                $0.isHidden = true
                            }
    
    let stepThreeCircleButton = UIButton().then {
        $0.setImage(UIImage(named: "icCircleNotfill"), for: .normal)
        $0.setImage(UIImage(named: "icCircleFill"), for: .selected)
        $0.isHidden = true
    }
    
    let startButton = UIButton().then {
        $0.setTitle("기업분석 시작하기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
        $0.isHidden = true
    }
    
    let dotStackOneView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<20 {
            let view = UIView().then {
                $0.backgroundColor = .clear
            }
            
            $0.addArrangedSubview(view)
        }
    }
    
    let dotStackTwoView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<20 {
            let view = UIView().then {
                $0.backgroundColor = .clear
            }
            
            $0.addArrangedSubview(view)
        }
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        startButton.rx.tap
            .bind { [weak self] in
                self?.view.removeFromSuperview()
                self?.removeFromParent()
            }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.stepOneCircleButton.isSelected = true
            UIView.transition(with: self.stepOne, duration: 2, options: .transitionCrossDissolve) {
                self.stepOne.isHidden = false
                self.stepOneCircleButton.isHidden = false
                
                let time = DispatchTime.now()
                for num in 0..<20 {
                    DispatchQueue.main.asyncAfter(deadline: time + 0.1 * Double((num + 1))) {
                        self.dotStackOneView.arrangedSubviews[num].backgroundColor = .mainColor
                    }
                }
            } completion: { _ in
                self.view.layoutIfNeeded()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.transition(with: self.stepTwo, duration: 2, options: .transitionCrossDissolve) {
                self.stepTwo.isHidden = false
                self.stepTwoCircleButton.isHidden = false
                
                self.stepOneCircleButton.isSelected = false
                self.stepTwoCircleButton.isSelected = true
                
                let time = DispatchTime.now()
                for num in 0..<20 {
                    DispatchQueue.main.asyncAfter(deadline: time + 0.1 * Double((num + 1))) {
                        self.dotStackTwoView.arrangedSubviews[num].backgroundColor = .mainColor
                    }
                }
            } completion: { _ in
                self.view.layoutIfNeeded()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            UIView.transition(with: self.stepThree, duration: 2, options: .transitionCrossDissolve) {
                self.stepThree.isHidden = false
                self.stepThreeCircleButton.isHidden = false
                
                self.stepTwoCircleButton.isSelected = false
                self.stepThreeCircleButton.isSelected = true
            } completion: { _ in
                self.view.layoutIfNeeded()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            UIView.transition(with: self.startButton, duration: 2, options: .transitionCrossDissolve) {
                self.startButton.isHidden = false
            } completion: { _ in
                
            }
        }
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(stepOne)
        view.addSubview(stepOneCircleButton)
        view.addSubview(dotStackOneView)
        
        view.addSubview(stepTwo)
        view.addSubview(stepTwoCircleButton)
        view.addSubview(dotStackTwoView)
        
        view.addSubview(stepThree)
        view.addSubview(stepThreeCircleButton)
        
        view.addSubview(startButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        stepOne.snp.makeConstraints { make in
            make.top.equalTo(view).offset(145)
            make.left.equalTo(stepOneCircleButton.snp.right).offset(17)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(146)
        }
        
        stepOneCircleButton.snp.makeConstraints { make in
            make.top.equalTo(stepOne).offset(3.5)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(26)
            make.width.height.equalTo(10)
        }
        
        dotStackOneView.snp.makeConstraints { make in
            make.top.equalTo(stepOneCircleButton.snp.bottom).offset(4)
            make.bottom.equalTo(stepTwoCircleButton.snp.top).offset(-4)
            make.centerX.equalTo(stepOneCircleButton)
            make.width.equalTo(2)
        }
        
        stepTwo.snp.makeConstraints { make in
            make.top.equalTo(stepOne.snp.bottom)
            make.left.right.equalTo(stepOne)
            make.height.equalTo(143)
        }
        
        stepTwoCircleButton.snp.makeConstraints { make in
            make.top.equalTo(stepTwo).offset(3.5)
            make.left.equalTo(stepOneCircleButton)
            make.width.height.equalTo(10)
        }
        
        dotStackTwoView.snp.makeConstraints { make in
            make.top.equalTo(stepTwoCircleButton.snp.bottom).offset(4)
            make.bottom.equalTo(stepThreeCircleButton.snp.top).offset(-4)
            make.centerX.equalTo(stepOneCircleButton)
            make.width.equalTo(2)
        }
        
        stepThree.snp.makeConstraints { make in
            make.top.equalTo(stepTwo.snp.bottom)
            make.left.right.equalTo(stepOne)
            make.height.equalTo(146)
        }
        
        stepThreeCircleButton.snp.makeConstraints { make in
            make.top.equalTo(stepThree).offset(3.5)
            make.left.equalTo(stepOneCircleButton)
            make.width.height.equalTo(10)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-51)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
}


