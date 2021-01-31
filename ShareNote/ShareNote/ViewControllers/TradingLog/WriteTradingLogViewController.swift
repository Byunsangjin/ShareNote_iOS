//
//  WriteTradingLogViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/31.
//

import UIKit

class WriteTradingLogViewController: UIViewController {

    // MARK: Constants
    let navigationTitleLabel = UILabel().then {
        $0.text = "매매일지 작성"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    let divisionLine = UIView().then {
        $0.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView().then {
        $0.backgroundColor = .green
    }
    
    let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let titleContainerView = UIView()
    
    let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let titleTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.borderStyle = .none
        $0.placeholder = "제목을 입력해주세요"
    }
    
    let tagContainerView = UIView()
    
    let tagLabel = UILabel().then {
        $0.text = "태그"
        $0.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let dateContainerView = UIView()
    
    let dateLabel = UILabel().then {
        $0.text = "날짜"
        $0.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let dateContentLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:42"
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let testView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setBottomLine()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationTitleLabel)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        view.addSubview(divisionLine)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(titleTextField)

        contentStackView.addArrangedSubview(tagContainerView)
        tagContainerView.addSubview(tagLabel)

        contentStackView.addArrangedSubview(dateContainerView)
        dateContainerView.addSubview(dateLabel)
        dateContainerView.addSubview(dateContentLabel)
        
        contentStackView.addArrangedSubview(testView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.centerX.equalTo(view)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(navigationTitleLabel)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(navigationTitleLabel)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
        
        divisionLine.snp.makeConstraints { make in
            make.top.equalTo(navigationTitleLabel.snp.bottom).offset(12)
            make.left.right.equalTo(view)
            make.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(divisionLine.snp.bottom)
            make.bottom.left.width.equalTo(view)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(scrollView)
            make.width.equalTo(view)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
            
        titleContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleContainerView)
            make.left.equalTo(titleContainerView).offset(20)
        }

        titleTextField.snp.makeConstraints { make in
            make.centerY.equalTo(titleContainerView)
            make.left.equalTo(titleLabel.snp.right).offset(60)
            make.right.lessThanOrEqualTo(titleContainerView).offset(-20)
        }

        tagContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        tagLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tagContainerView)
            make.left.equalTo(tagContainerView).offset(20)
        }

        dateContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateContainerView)
            make.left.equalTo(dateContainerView).offset(20)
        }

        dateContentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateContainerView)
            make.left.equalTo(dateLabel.snp.right).offset(60)
            make.right.lessThanOrEqualTo(dateContainerView).offset(-20)
        }
        
        testView.snp.makeConstraints { make in
            make.height.equalTo(1500)
        }
        
        super.updateViewConstraints()
    }
    
    func setBottomLine() {
        titleContainerView.addBottomLine()
        tagContainerView.addBottomLine()
        dateContainerView.addBottomLine()
    }
}
