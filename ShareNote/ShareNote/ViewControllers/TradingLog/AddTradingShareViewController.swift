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
    
    let scrollContentView = UIView()
    
    let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
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
    
    let buyButton = CategoryButton().then {
        $0.setTitle("매수", for: .normal)
    }
    
    let sellButton = CategoryButton().then {
        $0.setTitle("매도", for: .normal)
        $0.isUserInteractionEnabled = true
    }
    
    let dividendButton = CategoryButton().then {
        $0.setTitle("배당", for: .normal)
    }
    
    let noDealButton = CategoryButton().then {
        $0.setTitle("미거래", for: .normal)
    }
    
    // Buy Category Container
    let buyCategoryContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Trading Date Container
    let tradingDateContainerView = UIView()
    
    let tradingDateNameLabel = UILabel().createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "거래시간"
    }
    
    let tradingDateContentLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:43"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    
    let tradingDateChangeButton = UIButton().then {
        $0.setImage(UIImage(named: "icChange"), for: .normal)
        $0.setImage(UIImage(named: "icChange"), for: .highlighted)
    }
    
    // Purchase Price Container
    let purchasePriceContainerView = UIView()
    
    let purchasePriceNameLabel = UILabel().createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "매수가"
    }
    
    let purchasePriceTextFieldView = TextFieldView()
    
    let purchaseQuantityTextFieldView = TextFieldView().then {
        $0.label.text = "주"
    }
    
    // Appraised Price Container
    let appraisedPriceContainerView = UIView()
    
    let appraisedPriceNameLabel = UILabel().createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "평가금액"
    }
    
    let appraisedPriceTextFieldView = TextFieldView().then {
        $0.label.text = "원"
    }
    
    // Save Button
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = UIColor(red: 1, green: 214/255, blue: 8/255, alpha: 1)
        $0.layer.cornerRadius = 7
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        buyButton.isSelected = true
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
        
        contentStackView.addArrangedSubview(buyCategoryContainerStackView)
        
        buyCategoryContainerStackView.addArrangedSubview(tradingDateContainerView)
        tradingDateContainerView.addSubview(tradingDateNameLabel)
        tradingDateContainerView.addSubview(tradingDateContentLabel)
        tradingDateContainerView.addSubview(tradingDateChangeButton)
        
        buyCategoryContainerStackView.addArrangedSubview(purchasePriceContainerView)
        purchasePriceContainerView.addSubview(purchasePriceNameLabel)
        purchasePriceContainerView.addSubview(purchasePriceTextFieldView)
        purchasePriceContainerView.addSubview(purchaseQuantityTextFieldView)
        
        buyCategoryContainerStackView.addArrangedSubview(appraisedPriceContainerView)
        appraisedPriceContainerView.addSubview(appraisedPriceNameLabel)
        appraisedPriceContainerView.addSubview(appraisedPriceTextFieldView)
        
        view.addSubview(saveButton)
        
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
            make.left.width.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(saveButton.snp.top).offset(-7)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(scrollView)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints { make in            
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
        
        shareTitleContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        shareTitleNameLabel.snp.makeConstraints { make in
            make.left.equalTo(shareTitleContainerView).offset(20)
            make.centerY.equalTo(shareTitleContainerView)
        }
        
        shareSearchTextField.snp.makeConstraints { make in
            make.left.equalTo(shareTitleContainerView).offset(106)
            make.right.equalTo(shareTitleContainerView).offset(-22)
            make.centerY.equalTo(shareTitleContainerView)
            make.height.equalTo(22)
        }
        
        categoryContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
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
        
        buyCategoryContainerStackView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        tradingDateNameLabel.snp.makeConstraints { make in
            make.left.equalTo(tradingDateContainerView).offset(20)
            make.centerY.equalTo(tradingDateContainerView)
        }
        
        tradingDateContentLabel.snp.makeConstraints { make in
            make.left.equalTo(tradingDateContainerView).offset(106)
            make.right.equalTo(tradingDateChangeButton).offset(10)
            make.centerY.equalTo(tradingDateContainerView)
        }
        
        tradingDateChangeButton.snp.makeConstraints { make in
            make.right.equalTo(tradingDateContainerView).offset(-15)
            make.centerY.equalTo(tradingDateContainerView)
            make.width.height.equalTo(30)
        }
        
        purchasePriceNameLabel.snp.makeConstraints { make in
            make.left.equalTo(purchasePriceContainerView).offset(20)
            make.centerY.equalTo(purchasePriceContainerView)
        }
        
        purchasePriceTextFieldView.snp.makeConstraints { make in
            make.left.equalTo(purchasePriceContainerView).offset(106)
            make.right.equalTo(purchasePriceContainerView).offset(-113)
            make.centerY.equalTo(purchasePriceContainerView)
            make.height.equalTo(30)
        }

        purchaseQuantityTextFieldView.snp.makeConstraints { make in
            make.left.equalTo(purchasePriceTextFieldView.snp.right).offset(10)
            make.right.equalTo(purchasePriceContainerView).offset(-20)
            make.centerY.equalTo(purchasePriceContainerView)
            make.height.equalTo(30)
        }
            
        appraisedPriceNameLabel.snp.makeConstraints { make in
            make.left.equalTo(appraisedPriceContainerView).offset(20)
            make.centerY.equalTo(appraisedPriceContainerView)
        }
        
        appraisedPriceTextFieldView.snp.makeConstraints { make in
            make.left.equalTo(appraisedPriceContainerView).offset(106)
            make.right.equalTo(appraisedPriceContainerView).offset(-20)
            make.centerY.equalTo(appraisedPriceContainerView)
            make.height.equalTo(30)
        }

        saveButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-37)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
}

class CategoryButton: UIButton {
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor(red: 1, green: 214/255, blue: 8/255, alpha: 1) : .clear
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        self.setTitleColor(UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1), for: .normal)
        self.setTitleColor(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1), for: .selected)
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TextFieldView: UIView {
    let textField = UITextField().then {
        $0.textAlignment = .right
        $0.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    
    var label = UILabel().then {
        $0.textColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        addSubview(textField)
        addSubview(label)
    }
    
    override func updateConstraints() {
        textField.snp.makeConstraints { make in
            make.left.lessThanOrEqualTo(self).offset(10)
            make.right.equalTo(label.snp.left).offset(-5)
            make.centerY.equalTo(self)
        }
        
        label.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
        }
        
        super.updateConstraints()
    }
}
