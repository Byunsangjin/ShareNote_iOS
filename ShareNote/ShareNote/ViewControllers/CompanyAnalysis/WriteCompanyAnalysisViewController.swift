//
//  WriteCompanyAnalysisViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/21.
//

import UIKit

class WriteCompanyAnalysisViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "기업분석 작성"
        
        $0.leftBarButton.setImage(nil, for: .normal)
        $0.leftBarButton.setTitle("취소", for: .normal)
        $0.rightBarButton.setTitle("저장", for: .normal)
    }
    
    let contentStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    // Stock, Title, Tag ContainerView
    let stockContainerView = UIView()
    
    let stockTitleLabel = UILabel().then {
        $0.text = "종목"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let stockNameLabel = UILabel().then {
        $0.text = "삼성전자 005930"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let titleContainerView = UIView()
    
    let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = UIColor.grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let titleTextField = UITextField().then {
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.borderStyle = .none
        $0.placeholder = "제목을 입력해주세요"
    }
    
    let tagInputContainerView = UIView()
    
    let tagInputTitleLabel = UILabel().then {
        $0.text = "태그"
        $0.textColor = UIColor.grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let tagInputTextField = UITextField().then {
        $0.font = UIFont.spoqaHanSans(size: 14)
        $0.textColor = .black2
    }
    
    let tagAddButton = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let tagContainerView = UIView()
    
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
    
    let listTitleLabel = UILabel().then {
        $0.text = "질문 리스트"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let editButton = UIButton().then {
        let attributeString = NSAttributedString(string: "편집하기",
                                                 attributes: [NSAttributedString.Key.font : UIFont.spoqaHanSans(size: 11),
                                                              NSAttributedString.Key.foregroundColor : UIColor.grey3,
                                                              NSAttributedString.Key.underlineStyle : true])
        $0.setAttributedTitle(attributeString, for: .normal)
    }
    
    let listTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: Variables
    var questionList = ["시가총액은 얼마인가요?",
                        "작년 영업이익률은 몇퍼센트였나요?최대",
                        "경쟁사는 어떤 기업인가요?",
                        "주요 상품/서비스는 무엇인가요?"]
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.register(QuestListTableViewCell.self, forCellReuseIdentifier: "QuestListTableViewCell")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(stockContainerView)
        stockContainerView.addSubview(stockTitleLabel)
        stockContainerView.addSubview(stockNameLabel)
        
        contentStackView.addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(titleTextField)
        
        contentStackView.addArrangedSubview(tagInputContainerView)
        tagInputContainerView.addSubview(tagInputTitleLabel)
        tagInputContainerView.addSubview(tagInputTextField)
        tagInputContainerView.addSubview(tagAddButton)
        
        contentStackView.addArrangedSubview(tagContainerView)
        tagContainerView.addSubview(tagScrollView)
        tagScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(tagStackView)
        
        for _ in 0..<10 {
            let button = UIButton().then {
                $0.setTitle("#보여지고", for: .normal)
                $0.setTitleColor(UIColor.black2, for: .normal)
                $0.titleLabel?.font = UIFont.spoqaHanSans(size: 10, style: .Regular)
                $0.backgroundColor = UIColor.tag
                $0.layer.cornerRadius = 12
                $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            }
            tagStackView.addArrangedSubview(button)
        }
        
        view.addSubview(listTitleLabel)
        view.addSubview(editButton)
        
        view.addSubview(listTableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(34)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(194)
        }
        
        stockContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        stockTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(stockContainerView).offset(20)
            make.centerY.equalTo(stockContainerView)
        }
        
        stockNameLabel.snp.makeConstraints { make in
            make.left.equalTo(stockTitleLabel).offset(60)
            make.centerY.equalTo(stockContainerView)
        }
        
        titleContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleContainerView).offset(20)
            make.centerY.equalTo(titleContainerView)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.left.equalTo(titleLabel).offset(60)
            make.right.equalTo(titleContainerView).offset(-20)
            make.centerY.equalTo(titleContainerView)
        }
        
        tagInputContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        tagInputTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(tagInputContainerView).offset(20)
            make.centerY.equalTo(tagInputContainerView)
        }
        
        tagInputTextField.snp.makeConstraints { make in
            make.left.equalTo(tagInputTitleLabel).offset(60)
            make.right.equalTo(tagAddButton.snp.right).offset(-20)
            make.centerY.equalTo(tagInputContainerView)
        }
        
        tagAddButton.snp.makeConstraints { make in
            make.right.equalTo(tagInputContainerView).offset(-20)
            make.centerY.equalTo(tagInputContainerView)
        }
        
        tagContainerView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        tagScrollView.snp.makeConstraints { make in
            make.left.equalTo(tagContainerView).offset(20)
            make.right.equalTo(tagContainerView).offset(-20)
            make.centerY.equalTo(tagContainerView)
            make.height.equalTo(20)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.right.equalTo(tagScrollView)
            make.height.equalTo(tagScrollView)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
        
        listTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentStackView.snp.bottom).offset(35)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(listTitleLabel)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-23)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(listTitleLabel.snp.bottom).offset(18)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-11)
        }
        
        super.updateViewConstraints()
    }
}

extension WriteCompanyAnalysisViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestListTableViewCell") as? QuestListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = questionList[indexPath.row]
        
        if indexPath.row == 1 {
            cell.complete()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
