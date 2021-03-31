//
//  CompleteCompanyAnalysisViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/23.
//

import RxSwift
import UIKit

class CompleteCompanyAnalysisViewController: UIViewController {

    // MARK: Constants
    // Navigation ContainerView
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "기업분석 작성"
        $0.rightBarButton.setTitle("편집", for: .normal)
        $0.backgroundColor = .mainColor
        $0.borderColor = .clear
    }
    
    // CompleteCompanyAnalysis ContainerView
    let completeCompanyAnalysisContainerView = UIView().then {
        $0.backgroundColor = UIColor.mainColor
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:43"
        $0.textColor = UIColor.mainBrown
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let stockLabel = UILabel().then {
        $0.text = "삼성전자 005930"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Bold)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "글로벌 넘버 1 파운더리"
        $0.textColor = UIColor.black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
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
    
    let tableContainerView = UIView().then {
        $0.backgroundColor = .grey8
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    // MARK: Variables
    var tagList = ["#파운더리", "#반도체", "#DRAM"]
    
    var titleList = ["작년 영업이익률은 몇퍼센트였나요?최대", "시가총액은 얼마인가요?", "작년 영업이익률은 몇퍼센트였나요?최대", "작년 영업이익률은 몇퍼센트였나요?최대"]
    
    var descriptionList = ["0000조 0000억", "반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.",
                           "반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한나뉘나뉘나뉘어지는데 …","더보기는 7줄을 초과했을 때 보이며, 더보기를 클릭 시 !!!!   이렇게 보입니다.             며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한나뉘나뉘나뉘어지는데며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한나뉘나뉘나뉘어지는데 …며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한나뉘나뉘나뉘어지는데 …며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다.반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한나뉘나뉘나뉘어지는데 …"]
    
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CompleteCompanyAnalysisTableViewCell.self, forCellReuseIdentifier: "CompleteCompanyAnalysisTableViewCell")
        
        navigationView.leftBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        navigationView.rightBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(completeCompanyAnalysisContainerView)
        completeCompanyAnalysisContainerView.addSubview(dateLabel)
        completeCompanyAnalysisContainerView.addSubview(stockLabel)
        completeCompanyAnalysisContainerView.addSubview(titleLabel)
        
        for index in 0..<3 {
            let button = UIButton().then {
                $0.setTitle(tagList[index], for: .normal)
                $0.setTitleColor(UIColor.black2, for: .normal)
                $0.titleLabel?.font = UIFont.spoqaHanSans(size: 10, style: .Regular)
                $0.backgroundColor = UIColor.tag
                $0.layer.cornerRadius = 12
                $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            }
            tagStackView.addArrangedSubview(button)
        }
        
        completeCompanyAnalysisContainerView.addSubview(tagScrollView)
        tagScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(tagStackView)
        
        view.addSubview(tableContainerView)
        tableContainerView.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        completeCompanyAnalysisContainerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(165)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(completeCompanyAnalysisContainerView.snp.top).offset(34)
            make.left.equalTo(completeCompanyAnalysisContainerView).offset(20)
            make.right.equalTo(completeCompanyAnalysisContainerView).offset(-20)
        }
        
        stockLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.right.equalTo(dateLabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stockLabel.snp.bottom).offset(12)
            make.left.right.equalTo(dateLabel)
        }
        
        tagScrollView.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(completeCompanyAnalysisContainerView).offset(-20)
            make.height.equalTo(20)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.right.equalTo(tagScrollView)
            make.height.equalTo(tagScrollView)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
        
        tableContainerView.snp.makeConstraints { make in
            make.top.equalTo(completeCompanyAnalysisContainerView.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableContainerView).offset(20)
            make.left.right.bottom.equalTo(tableContainerView)
        }
        
        super.updateViewConstraints()
    }
}

extension CompleteCompanyAnalysisViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteCompanyAnalysisTableViewCell") as? CompleteCompanyAnalysisTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = titleList[indexPath.row]
        cell.descriptionLabel.text = descriptionList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
