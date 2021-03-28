//
//  SelectionViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/14.
//

import RxSwift
import UIKit

@objc protocol SelectionViewDelegate {
    func didSelectCompany(title: String)
            
    @objc optional func changeButtonTouched()
}

class SelectionViewController: UIViewController {

    // MARK: Constants
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icClose"), for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "기업분석 작성하기"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 26)
    }
    
    let companySelectionContainerView = CompanySelectionView(numberOfStep: 1, title: "관심있는 기업선택", isEnable: true)
    
    let questionSelectionContainerView = CompanySelectionView(numberOfStep: 2, title: "맞춤 질문 구성하기", isEnable: false)
    
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        companySelectionContainerView.delegate = self
        
        closeButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        companySelectionContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                                  action: #selector(companySelectionViewTouched)))
        
        questionSelectionContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                                   action: #selector(questionSelectionViewTouched)))
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        
        view.addSubview(titleLabel)
        
        view.addSubview(companySelectionContainerView)
        view.addSubview(questionSelectionContainerView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(47)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(71)
            make.left.equalTo(closeButton)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        companySelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(80)
        }
        
        questionSelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(companySelectionContainerView.snp.bottom).offset(20)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(80)
        }
        
        super.updateViewConstraints()
    }
    
    @objc
    func companySelectionViewTouched() {
        let companySearchViewController = CompanySearchViewController()
        companySearchViewController.delegate = self
        navigationController?.pushViewController(companySearchViewController, animated: true)
    }
    
    @objc
    func questionSelectionViewTouched() {
        let questionSelectViewController = QuestionSelectViewController()
        navigationController?.pushViewController(questionSelectViewController, animated: true)
    }
}

extension SelectionViewController: SelectionViewDelegate {
    func didSelectCompany(title: String) {
        let string = title.replacingOccurrences(of: " ", with: "\n")
        let lastString = string.split(separator: "\n").map(String.init).last!
        let attributeText = NSMutableAttributedString(string: string,
                                                      attributes: [.font : UIFont.spoqaHanSans(size: 12),
                                                                   .foregroundColor : UIColor.grey4])
        attributeText.addAttribute(.font, value: UIFont.spoqaHanSans(size: 16), range: (string as NSString).range(of: lastString))
        companySelectionContainerView.titleLabel.attributedText = attributeText
        companySelectionContainerView.isEnable = false
        questionSelectionContainerView.isEnable = true
    }
    
    func changeButtonTouched() {
        companySelectionViewTouched()
    }
}
