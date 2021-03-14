//
//  CompanyAnalysisMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import PanModal
import RxSwift
import UIKit

class CompanyAnalysisMainViewController: UIViewController {
    
    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "기업분석"
        $0.leftBarButton.setImage(UIImage(named: "icMyHoneyPage"), for: .normal)
        $0.rightBarButton.setImage(UIImage(named: "icEdit"), for: .normal)
    }
    
    // Empty View
    let emptyView = UIView().then {
        $0.backgroundColor = .clear
        $0.isHidden = true
    }
    
    let emptyillustImage = UIImageView().then {
        $0.image = UIImage(named: "illustWrite")
    }
    
    let emptyLabel = UILabel().then {
        $0.text = "엄선된 질문으로 다양한 관점에서\n기업 분석을 시작하세요"
        $0.textColor = .grey1
        $0.font = UIFont.spoqaHanSans(size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let writeButton = UIButton().then {
        $0.setTitle("작성하기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
    }
    
    // Main
    let categoryButton = UIButton().then {
        $0.setTitle("전체", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.setImage(UIImage(named: "icArrowDown2"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets.left = 11
        $0.imageEdgeInsets.left = 27
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.grey6.cgColor
        $0.layer.cornerRadius = 4
    }
    
    let testTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        testTableView.delegate = self
        testTableView.dataSource = self
        testTableView.register(AnalysisTableViewCell.self, forCellReuseIdentifier: "AnalysisTableViewCell")
        
        categoryButton.rx.tap
            .bind { [weak self] in
                self?.presentPanModal(CategoryTableViewController())
            }.disposed(by: disposeBag)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = .grey8
        tabBarItem = UITabBarItem(title: "기업분석", image: UIImage(named: "icBarAnalysis"), selectedImage: UIImage(named: "icBarAnalysisSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        view.addSubview(navigationView)
        
        view.addSubview(emptyView)
        emptyView.addSubview(emptyillustImage)
        emptyView.addSubview(emptyLabel)
        emptyView.addSubview(writeButton)
        
        view.addSubview(categoryButton)
        
        view.addSubview(testTableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        // Empty View
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyillustImage.snp.makeConstraints { make in
            make.top.equalTo(emptyView).offset(80)
            make.centerX.equalTo(emptyView)
            make.width.equalTo(103.5)
            make.height.equalTo(160)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyillustImage.snp.bottom).offset(27)
            make.centerX.equalTo(emptyillustImage)
        }
        
        writeButton.snp.makeConstraints { make in
            make.top.equalTo(emptyLabel.snp.bottom).offset(20)
            make.centerX.equalTo(emptyillustImage)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        
        // Main
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(70)
            make.height.equalTo(36)
        }
        
        testTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
}

extension CompanyAnalysisMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisTableViewCell") as? AnalysisTableViewCell else {
            return UITableViewCell()
        }
                
        if indexPath.row == 1 {
            cell.changeTempCellColor()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
