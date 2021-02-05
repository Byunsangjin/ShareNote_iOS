//
//  AddTradingShareViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/05.
//

import UIKit

class AddTradingShareViewController: UIViewController {

    static let nameLabelFont = UIFont.systemFont(ofSize: 14)
    static let nameLabelTextColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
    
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "거래주식"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icClose"), for: .normal)
        $0.setImage(UIImage(named: "icClose"), for: .highlighted)
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
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Share Title Container
    let shareTitleContainerView = UIView()
    
    let shareTitleNameLabel = UILabel().createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "주식명"
    }
    
    let shareSearchTextField = UITextField().then {
        $0.placeholder = "종목코드/명 검색"
    }
    
    // Category Container
    let categoryContainerView = UIView()
    
    let categoryNameLabel = UILabel().createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "분류"
    }
    
    let buyButton = UIButton().then {
        $0.setTitle("매수", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let sellButton = UIButton().then {
        $0.setTitle("매도", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let dividendButton = UIButton().then {
        $0.setTitle("배당", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let noDealButton = UIButton().then {
        $0.setTitle("미거래", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    // Trading Date Container
    let tradingContainerView = UIView()
    
    // Purchase Price Container
    let purchasePriceContainerView = UIView()
    
    // Appraised Price Container
    let appraisedPriceContainerView = UIView()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(shareTitleContainerView)
        shareTitleContainerView.addSubview(shareTitleNameLabel)
        shareTitleContainerView.addSubview(shareSearchTextField)
        
        contentStackView.addArrangedSubview(categoryContainerView)
        categoryContainerView.addSubview(categoryNameLabel)
        categoryContainerView.addSubview(buyButton)
        categoryContainerView.addSubview(sellButton)
        categoryContainerView.addSubview(dividendButton)
        categoryContainerView.addSubview(noDealButton)
        
        contentStackView.addArrangedSubview(tradingContainerView)
        
        contentStackView.addArrangedSubview(purchasePriceContainerView)
        
        contentStackView.addArrangedSubview(appraisedPriceContainerView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(14)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.height.equalTo(30)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.bottom.left.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(scrollView)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
        
        shareTitleNameLabel.snp.makeConstraints { make in
            make.left.equalTo(shareTitleContainerView).offset(20)
            make.centerY.equalTo(shareTitleContainerView)
        }
        
        shareSearchTextField.snp.makeConstraints { make in
            make.left.equalTo(shareTitleContainerView).offset(106)
            make.right.equalTo(shareTitleContainerView).offset(-22)
            make.centerY.equalTo(shareTitleContainerView)
        }
 
        categoryNameLabel.snp.makeConstraints { make in
            make.left.equalTo(categoryContainerView).offset(20)
            make.centerY.equalTo(categoryContainerView)
        }
        
        buyButton.snp.makeConstraints { make in
            make.left.equalTo(shareTitleContainerView).offset(106)
            make.centerY.equalTo(categoryContainerView)
            make.width.equalTo(50)
            make.height.equalTo(26)
        }
        
        sellButton.snp.makeConstraints { make in
            make.left.equalTo(buyButton.snp.right).offset(5)
            make.centerY.width.height.equalTo(buyButton)
            
        }
        
        dividendButton.snp.makeConstraints { make in
            make.left.equalTo(sellButton.snp.right).offset(5)
            make.centerY.width.height.equalTo(buyButton)
        }
        
        noDealButton.snp.makeConstraints { make in
            make.left.equalTo(dividendButton.snp.right).offset(5)
            make.centerY.width.equalTo(buyButton)
            make.height.equalTo(26)
        }
        
        super.updateViewConstraints()
    }
}
