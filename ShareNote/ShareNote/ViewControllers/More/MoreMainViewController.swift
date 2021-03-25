//
//  MoreMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import RxSwift
import UIKit

class MoreMainViewController: UIViewController {
    
    // MARK: Constants
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let titleLabel = UILabel().then {
        $0.text = "더보기"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 20)
    }
    
    let nameLabel = UILabel().then {
        $0.text = "김쉐어"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 18)
    }
    
    let detailButton = UIButton().then {
        $0.setImage(UIImage(named: "iconsMidDetail"), for: .normal)
        $0.tintColor = .black
    }
    
    let moveHiveContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.applySketchShadow(color: .black1, alpha: 0.1, x: 0, y: 2, blur: 5, spread: 0)
    }
    
    let hiveIconImageView = UIImageView().then {
        $0.image = UIImage(named: "iconHoney")
    }
    
    let hiveLabel = UILabel().then {
        $0.text = "벌집 확인하기"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let hiveMoveButton = UIButton().then {
        $0.setImage(UIImage(named: "iconsFold"), for: .normal)
        $0.tintColor = .black
    }
    
    let serviceCenterButton = UIButton().then {
        $0.setImage(UIImage(named: "icPlus1Service"), for: .normal)
    }
    
    let serviceCenterLabel = UILabel().then {
        $0.text = "고객센터"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let noticeButton = UIButton().then {
        $0.setImage(UIImage(named: "icPlus2Notice"), for: .normal)
    }
    
    let noticeLabel = UILabel().then {
        $0.text = "공지사항"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let eventButton = UIButton().then {
        $0.setImage(UIImage(named: "icPlus3Event"), for: .normal)
    }
    
    let eventLabel = UILabel().then {
        $0.text = "이벤트"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let tableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
    }
    
    let cellTitleArr = [["계정 관리", "잠금설정", "알림설정"],
                        ["약관 및 개인정보처리", "오픈소스 라이센스"],
                        ["버전정보"]]
    
    let moveViewControllerList = [[AccountManagementViewController(), LockModeSettingViewController(), AlarmSettingViewController()],
                                  [TermsAndPersonalInfoProcessingViewController(), nil],
                                  [AppVersionViewController()]]
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "더보기", image: UIImage(named: "icBarAdd"), selectedImage: UIImage(named: "icBarAddSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        tableView.register(MoreMenuTableViewCell.self, forCellReuseIdentifier: "MoreMenuTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        detailButton.rx.tap
            .bind { [weak self] in
                let userInfoViewController = UserInfoViewController()
                self?.navigationController?.pushViewController(userInfoViewController, animated: true)
            }.disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(titleLabel)
        
        scrollContentView.addSubview(nameLabel)
        scrollContentView.addSubview(detailButton)
        
        scrollContentView.addSubview(moveHiveContainerView)
        moveHiveContainerView.addSubview(hiveIconImageView)
        moveHiveContainerView.addSubview(hiveLabel)
        moveHiveContainerView.addSubview(hiveMoveButton)
        
        scrollContentView.addSubview(serviceCenterButton)
        scrollContentView.addSubview(serviceCenterLabel)
        scrollContentView.addSubview(noticeButton)
        scrollContentView.addSubview(noticeLabel)
        scrollContentView.addSubview(eventButton)
        scrollContentView.addSubview(eventLabel)
        
        scrollContentView.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.bottom.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.width.equalTo(scrollView)
            make.height.equalTo(757)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(60)
            make.left.equalTo(scrollContentView).offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(31)
            make.left.equalTo(scrollContentView).offset(20)
        }
        
        detailButton.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right)
            make.centerY.equalTo(nameLabel)
            make.width.height.equalTo(20)
        }
        
        moveHiveContainerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(23)
            make.centerX.equalTo(scrollContentView)
            make.width.equalTo(scrollContentView).offset(-40)
            make.height.equalTo(45)
        }
        
        hiveIconImageView.snp.makeConstraints { make in
            make.left.equalTo(moveHiveContainerView).offset(10)
            make.centerY.equalTo(moveHiveContainerView)
            make.width.height.equalTo(30)
        }
        
        hiveLabel.snp.makeConstraints { make in
            make.left.equalTo(hiveIconImageView.snp.right).offset(5)
            make.centerY.equalTo(moveHiveContainerView)
        }
        
        hiveMoveButton.snp.makeConstraints { make in
            make.right.equalTo(moveHiveContainerView).offset(-5)
            make.centerY.equalTo(moveHiveContainerView)
            make.width.height.equalTo(30)
        }
        
        serviceCenterButton.snp.makeConstraints { make in
            make.top.equalTo(moveHiveContainerView.snp.bottom).offset(25)
            make.left.equalTo(scrollContentView).offset(51)
            make.width.height.equalTo(50)
        }
        
        serviceCenterLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceCenterButton.snp.bottom)
            make.centerX.equalTo(serviceCenterButton)
        }
        
        noticeButton.snp.makeConstraints { make in
            make.top.equalTo(serviceCenterButton)
            make.centerX.equalTo(scrollContentView)
            make.width.height.equalTo(50)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeButton.snp.bottom)
            make.centerX.equalTo(noticeButton)
        }
        
        eventButton.snp.makeConstraints { make in
            make.top.equalTo(serviceCenterButton)
            make.right.equalTo(scrollContentView).offset(-51)
            make.width.height.equalTo(50)
        }
        
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(eventButton.snp.bottom)
            make.centerX.equalTo(eventButton)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(serviceCenterLabel.snp.bottom).offset(40)
            make.left.right.bottom.equalTo(scrollContentView)
        }
        
        super.updateViewConstraints()
    }
}

extension MoreMainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreMenuTableViewCell") as? MoreMenuTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = cellTitleArr[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 && indexPath.row == 1 {
            cell.descriptionLabel.text = "사용 안 함"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if let moveViewController = moveViewControllerList[section][row] {
            self.navigationController?.pushViewController(moveViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView
        
        switch section {
        case 0:
            view = MoreMenuHeaderView(title: "개인/보안")
        case 1:
            view = MoreMenuHeaderView(title: "약관 및 정책")
        default:
            view = UIView()
            view.backgroundColor = .whiteTwo
            break
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 5
        }

        return 42
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 5
        }
        
        return 47
    }
}
