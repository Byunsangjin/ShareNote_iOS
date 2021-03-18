//
//  QuestionSelectViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/15.
//

import UIKit
import ExpyTableView

class QuestionSelectViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "질문 구성하기"
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView().then {
        $0.backgroundColor = .grey8
    }
    
    let selectionView = UIView.createTradingShareCellView()
    
    let selectionViewTitleLabel = UILabel().then {
        $0.text = "선택한 기업"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let stockNameLabel = UILabel().then {
        $0.text = "삼성전자"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16)
    }
    
    let stockChangeButton = UIButton().then {
        $0.setTitle("변경하기", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let questionCountView = UIView.createTradingShareCellView()
    
    let questionCountViewTitleLabel = UILabel().then {
        $0.text = "선택한 질문 갯수"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let countTitleLabel = UILabel().then {
        $0.text = "10개"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16)
    }
    
    let countDotStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 6
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let countLabel = UILabel().then {
        $0.text = "+5"
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 11)
    }
    
    let categoryTitleLabel = UILabel().then {
        $0.text = "관련카테고리"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let questionTableView = ExpyTableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .whiteTwo
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        questionTableView.delegate = self
        questionTableView.dataSource = self
        questionTableView.expandingAnimation = .top
        questionTableView.collapsingAnimation = .top
        
        questionTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        questionTableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: "QuestionTableViewCell")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(selectionView)
        selectionView.addSubview(selectionViewTitleLabel)
        selectionView.addSubview(stockNameLabel)
        selectionView.addSubview(stockChangeButton)
        
        scrollContentView.addSubview(questionCountView)
        questionCountView.addSubview(questionCountViewTitleLabel)
        questionCountView.addSubview(countTitleLabel)
        questionCountView.addSubview(countDotStackView)
        for _ in 0..<5 {
            countDotStackView.addArrangedSubview(UIView().then {
                $0.backgroundColor = .mainColor
                $0.layer.cornerRadius = 3.5
            })
        }
        questionCountView.addSubview(countLabel)
        
        scrollContentView.addSubview(categoryTitleLabel)
        
        scrollView.addSubview(questionTableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.width.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.width.bottom.equalTo(scrollView)
            make.height.equalTo(1000)
        }
        
        selectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(16)
            make.left.equalTo(scrollContentView).offset(20)
            make.width.equalToSuperview().offset(-23.5).multipliedBy(0.5)
            make.height.equalTo(84)
        }
        
        selectionViewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(selectionView).offset(12)
            make.centerX.equalTo(selectionView)
        }
        
        stockNameLabel.snp.makeConstraints { make in
            make.top.equalTo(selectionViewTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(selectionView)
        }
        
        stockChangeButton.snp.makeConstraints { make in
            make.top.equalTo(stockNameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(selectionView)
            make.height.equalTo(15)
        }
        
        questionCountView.snp.makeConstraints { make in
            make.top.width.height.equalTo(selectionView)
            make.right.equalTo(scrollContentView).offset(-20)
        }
        
        questionCountViewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(questionCountView).offset(12)
            make.centerX.equalTo(questionCountView)
        }
        
        countTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(questionCountViewTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(questionCountView)
        }
        
        countDotStackView.snp.makeConstraints { make in
            make.top.equalTo(countTitleLabel.snp.bottom).offset(14)
            make.left.equalTo(questionCountView).offset(44)
            make.width.equalTo(59)
            make.height.equalTo(7)
        }
        
        countLabel.snp.makeConstraints { make in
            make.left.equalTo(countDotStackView.snp.right).offset(5)
            make.centerY.equalTo(countDotStackView)
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(selectionView.snp.bottom).offset(30)
            make.left.equalTo(selectionView)
        }
        
        questionTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(20)
            make.width.equalTo(scrollContentView)
            make.centerX.equalTo(scrollContentView)
            make.bottom.equalTo(scrollContentView)
        }
        
        super.updateViewConstraints()
    }
}

extension QuestionSelectViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell") as? QuestionTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else {
            return
        }
        
        cell.changeLayer()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
