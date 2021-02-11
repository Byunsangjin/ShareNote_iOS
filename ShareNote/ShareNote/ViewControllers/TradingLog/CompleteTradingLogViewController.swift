//
//  CompleteTradingLogViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/11.
//

import UIKit
import RxSwift

class CompleteTradingLogViewController: UIViewController {
    
    // Navigation ContainerView
    let navigationContainerView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 214/255, blue: 8/255, alpha: 1)
    }
    
    let navigationTitleLabel = UILabel().then {
        $0.text = "매매일지 작성"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "icBack"), for: .normal)
    }
    
    let editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    // TradingLogTitle ContainerView
    let tradingLogTitleContainerView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 214/255, blue: 8/255, alpha: 1)
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:43"
        $0.textColor = UIColor(red: 111/255, green: 93/255, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "기아차 가즈아~~"
        $0.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let tagScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView()
    
    let tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let segmentControl = UISegmentedControl(items: ["거래주식", "관련기사", "메모"]).then {
        $0.selectedSegmentIndex = 0
    }
        
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        segmentControl.rx.selectedSegmentIndex
            .bind { property in
                self.segmentControl.changeUnderlinePosition()
            }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        segmentControl.addUnderlineForSelectedSegment()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationContainerView)
        navigationContainerView.addSubview(navigationTitleLabel)
        navigationContainerView.addSubview(backButton)
        navigationContainerView.addSubview(editButton)
        
        view.addSubview(tradingLogTitleContainerView)
        tradingLogTitleContainerView.addSubview(dateLabel)
        tradingLogTitleContainerView.addSubview(titleLabel)
        
        for _ in 0..<10 {
            let button = UIButton().then {
                $0.setTitle("#보여지고", for: .normal)
                $0.setTitleColor(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1), for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 10)
                $0.backgroundColor = UIColor(red: 1, green: 234/255, blue: 132/255, alpha: 1)
                $0.layer.cornerRadius = 12
                $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            }
            tagStackView.addArrangedSubview(button)
        }
        
        tradingLogTitleContainerView.addSubview(tagScrollView)
        tagScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(tagStackView)
        
        view.addSubview(segmentControl)
        segmentControl.removeBorder()
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationContainerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        navigationTitleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(navigationContainerView)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(navigationContainerView.safeAreaLayoutGuide).offset(15)
            make.centerY.equalTo(navigationContainerView)
            make.width.height.equalTo(30)
        }
        
        editButton.snp.makeConstraints { make in
            make.right.equalTo(navigationContainerView.safeAreaLayoutGuide).offset(-20)
            make.centerY.equalTo(navigationContainerView)
        }
        
        tradingLogTitleContainerView.snp.makeConstraints { make in
            make.top.equalTo(navigationContainerView.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(135)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingLogTitleContainerView.snp.top).offset(34)
            make.left.equalTo(tradingLogTitleContainerView).offset(20)
            make.right.equalTo(tradingLogTitleContainerView).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.equalTo(tradingLogTitleContainerView).offset(20)
            make.right.equalTo(tradingLogTitleContainerView).offset(-20)
        }
        
        tagScrollView.snp.makeConstraints { make in
            make.left.equalTo(tradingLogTitleContainerView).offset(20)
            make.right.bottom.equalTo(tradingLogTitleContainerView).offset(-20)
            make.height.equalTo(20)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.right.equalTo(tagScrollView)
            make.height.equalTo(tagScrollView)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(tradingLogTitleContainerView.snp.bottom)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(50)
        }
        
        super.updateViewConstraints()
    }
}
