//
//  AddTradingShareViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/05.
//

import Popover
import RxSwift
import UIKit

class AddTradingShareViewController: UIViewController {
    let popover = Popover(options: [
        .type(.auto),
        .blackOverlayColor(.clear),
        .arrowSize(CGSize(width: 0, height: 0)),
        .dismissOnBlackOverlayTap(false),
        .cornerRadius(0),
        
    ])
    
    static let nameLabelFont = UIFont.spoqaHanSans(size: 14)
    static let nameLabelTextColor = UIColor.grey3
    
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "거래주식"
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
        $0.textColor = UIColor.black2
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
    
    let shareTitleNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "주식명"
    }
    
    let shareSearchTextField = UITextField().then {
        $0.placeholder = "종목코드/명 검색"
    }
    
    // Category Container
    let categoryContainerView = UIView()
    
    let categoryNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
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
    
    // Buy Category StackView
    let buyCategoryStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    let tradingDateContainerView = UIView()
    
    let tradingDateNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "거래시간"
    }
    
    let tradingDateContentLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:43"
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.textColor = UIColor.black2
    }
    
    let tradingDateChangeButton = UIButton().then {
        $0.setImage(UIImage(named: "icChange"), for: .normal)
        $0.setImage(UIImage(named: "icChange"), for: .highlighted)
    }
    
    let purchasePriceContainerView = UIView()
    
    let purchasePriceNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "매수가"
    }
    
    let purchasePriceTextFieldView = TextFieldView()
    
    let purchaseQuantityTextFieldView = TextFieldView().then {
        $0.label.text = "주"
    }
    
    let appraisedPriceContainerView = UIView()
    
    let appraisedPriceNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "평가금액"
    }
    
    let appraisedPriceTextFieldView = TextFieldView().then {
        $0.label.text = "원"
    }
    
    // Dividend StackView
    let dividendStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
     
    let dividendCycleContainerView = UIView()
    
    let dividendCycleNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "배당주기"
    }
    
    let dividendCycleTextFieldView = TextFieldView().then {
        $0.label.text = "회/연"
    }
    
    let presentPriceContainerView = UIView()
    
    let presentPriceNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "현재가"
    }
    
    let presentPriceTextFieldView = TextFieldView().then {
        $0.label.text = "원"
    }
    
    let dividendsPerShareContainerView = UIView()
    
    let dividendsPerShareNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "주당 배당금"
    }
    
    let dividendsPerSharePriceTextField = TextFieldView().then {
        $0.label.text = "원"
    }
    
    let dividendsPerShareAmountTextField = TextFieldView().then {
        $0.label.text = "주"
    }
    
    let totalDividentPriceContainerView = UIView()
    
    let totalDividentPriceTextField = TextFieldView().then {
        $0.label.text = "원"
    }
    
    let dividendRateContainerView = UIView()
    
    let dividendRateNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "배당 수익률"
    }
    
    let dividendRateTextField = TextFieldView().then {
        $0.label.text = "%"
    }
    
    // NoDeal StackView
    let noDealStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    let noDealPresentPriceContainerView = UIView()
    
    let noDealPresentPriceNameLabel = UILabel.createLabel(font: nameLabelFont, textColor: nameLabelTextColor).then {
        $0.text = "현재가"
    }
    
    let noDealPresentPriceTextFieldView = TextFieldView().then {
        $0.label.text = "원"
    }

    // Save Button
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(UIColor.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = UIColor.mainColor
        $0.layer.cornerRadius = 7
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        buyButton.isSelected = true
        
        shareSearchTextField.delegate = self
        
        closeButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        saveButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        shareTitleContainerView.addBottomLine()
        categoryContainerView.addBottomLine()
        tradingDateContainerView.addBottomLine()
        purchasePriceContainerView.addBottomLine()
        appraisedPriceContainerView.addBottomLine()
        dividendCycleContainerView.addBottomLine()
        presentPriceContainerView.addBottomLine()
        totalDividentPriceContainerView.addBottomLine()
        dividendRateContainerView.addBottomLine()
        noDealPresentPriceContainerView.addBottomLine()
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
        
        addBuyCategoryView()
        addDividendView()
        addNoDealView()
        
        buyCategoryStackView.isHidden = false
        dividendStackView.isHidden = true
        noDealStackView.isHidden = true
        
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
        
        buyCategoryStackView.snp.makeConstraints { make in
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
        
        dividendStackView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
        
        dividendCycleNameLabel.snp.makeConstraints { make in
            make.left.equalTo(dividendCycleContainerView).offset(20)
            make.centerY.equalTo(dividendCycleContainerView)
        }
        
        dividendCycleTextFieldView.snp.makeConstraints { make in
            make.left.equalTo(dividendCycleContainerView).offset(106)
            make.right.equalTo(dividendCycleContainerView).offset(-20)
            make.centerY.equalTo(dividendCycleContainerView)
            make.height.equalTo(30)
        }
        
        presentPriceNameLabel.snp.makeConstraints { make in
            make.left.equalTo(presentPriceContainerView).offset(20)
            make.centerY.equalTo(presentPriceContainerView)
        }
        
        presentPriceTextFieldView.snp.makeConstraints { make in
            make.left.equalTo(presentPriceContainerView).offset(106)
            make.right.equalTo(presentPriceContainerView).offset(-20)
            make.centerY.equalTo(presentPriceContainerView)
            make.height.equalTo(30)
        }
        
        dividendsPerShareNameLabel.snp.makeConstraints { make in
            make.left.equalTo(dividendsPerShareContainerView).offset(20)
            make.centerY.equalTo(dividendsPerShareContainerView)
        }
        
        dividendsPerSharePriceTextField.snp.makeConstraints { make in
            make.left.equalTo(dividendsPerShareContainerView).offset(106)
            make.right.equalTo(dividendsPerShareContainerView).offset(-113)
            make.centerY.equalTo(dividendsPerShareContainerView)
            make.height.equalTo(30)
        }
        
        dividendsPerShareAmountTextField.snp.makeConstraints { make in
            make.left.equalTo(dividendsPerSharePriceTextField.snp.right).offset(10)
            make.right.equalTo(dividendsPerShareContainerView).offset(-20)
            make.centerY.equalTo(dividendsPerSharePriceTextField)
            make.height.equalTo(30)
        }
        
        totalDividentPriceTextField.snp.makeConstraints { make in
            make.left.equalTo(totalDividentPriceContainerView).offset(106)
            make.right.equalTo(totalDividentPriceContainerView).offset(-20)
            make.centerY.equalTo(totalDividentPriceContainerView)
            make.height.equalTo(30)
        }
        
        dividendRateNameLabel.snp.makeConstraints { make in
            make.left.equalTo(dividendRateContainerView).offset(20)
            make.centerY.equalTo(dividendRateContainerView)
        }
        
        dividendRateTextField.snp.makeConstraints { make in
            make.left.equalTo(dividendRateContainerView).offset(106)
            make.right.equalTo(dividendRateContainerView).offset(-20)
            make.centerY.equalTo(dividendRateContainerView)
            make.height.equalTo(30)
        }
        
        noDealStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        noDealPresentPriceNameLabel.snp.makeConstraints { make in
            make.left.equalTo(noDealPresentPriceContainerView).offset(20)
            make.centerY.equalTo(noDealPresentPriceContainerView)
        }
        
        noDealPresentPriceTextFieldView.snp.makeConstraints { make in
            make.left.equalTo(noDealPresentPriceContainerView).offset(106)
            make.right.equalTo(noDealPresentPriceContainerView).offset(-20)
            make.centerY.equalTo(noDealPresentPriceContainerView)
            make.height.equalTo(30)
        }

        saveButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-7)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
    
    func addBuyCategoryView() {
        contentStackView.addArrangedSubview(buyCategoryStackView)
        
        buyCategoryStackView.addArrangedSubview(tradingDateContainerView)
        tradingDateContainerView.addSubview(tradingDateNameLabel)
        tradingDateContainerView.addSubview(tradingDateContentLabel)
        tradingDateContainerView.addSubview(tradingDateChangeButton)
        
        buyCategoryStackView.addArrangedSubview(purchasePriceContainerView)
        purchasePriceContainerView.addSubview(purchasePriceNameLabel)
        purchasePriceContainerView.addSubview(purchasePriceTextFieldView)
        purchasePriceContainerView.addSubview(purchaseQuantityTextFieldView)
        
        buyCategoryStackView.addArrangedSubview(appraisedPriceContainerView)
        appraisedPriceContainerView.addSubview(appraisedPriceNameLabel)
        appraisedPriceContainerView.addSubview(appraisedPriceTextFieldView)
    }
    
    func addDividendView() {
        contentStackView.addArrangedSubview(dividendStackView)
        
        dividendStackView.addArrangedSubview(dividendCycleContainerView)
        dividendCycleContainerView.addSubview(dividendCycleNameLabel)
        dividendCycleContainerView.addSubview(dividendCycleTextFieldView)
        
        dividendStackView.addArrangedSubview(presentPriceContainerView)
        presentPriceContainerView.addSubview(presentPriceNameLabel)
        presentPriceContainerView.addSubview(presentPriceTextFieldView)
        
        dividendStackView.addArrangedSubview(dividendsPerShareContainerView)
        dividendsPerShareContainerView.addSubview(dividendsPerShareNameLabel)
        dividendsPerShareContainerView.addSubview(dividendsPerSharePriceTextField)
        dividendsPerShareContainerView.addSubview(dividendsPerShareAmountTextField)
        
        dividendStackView.addArrangedSubview(totalDividentPriceContainerView)
        totalDividentPriceContainerView.addSubview(totalDividentPriceTextField)
        
        dividendStackView.addArrangedSubview(dividendRateContainerView)
        dividendRateContainerView.addSubview(dividendRateNameLabel)
        dividendRateContainerView.addSubview(dividendRateTextField)
    }
    
    func addNoDealView() {
        contentStackView.addArrangedSubview(noDealStackView)
        
        noDealStackView.addArrangedSubview(noDealPresentPriceContainerView)
        noDealPresentPriceContainerView.addSubview(noDealPresentPriceNameLabel)
        noDealPresentPriceContainerView.addSubview(noDealPresentPriceTextFieldView)
    }
}

extension AddTradingShareViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showPopover()
        
        return true
    }
    
    func showPopover() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.shareSearchTextField.frame.width, height: 135))
        
        containerView.layer.addBorder([.top], color: UIColor.mainColor, width: 3)
        containerView.layer.addBorder([.left, .right, .bottom], color: UIColor.grey6, width: 1)
        
        let tableViewFrame = containerView.frame.inset(by: UIEdgeInsets(top: 3, left: 1, bottom: 1, right: 1))
        let tableView = UITableView(frame: tableViewFrame)
        
        containerView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        popover.blackOverlay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchOutside)))
        popover.show(containerView, fromView: self.shareSearchTextField)
    }
    
    @objc
    func touchOutside() {
        self.shareSearchTextField.endEditing(true)
        self.popover.dismiss()
    }
}

extension AddTradingShareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
