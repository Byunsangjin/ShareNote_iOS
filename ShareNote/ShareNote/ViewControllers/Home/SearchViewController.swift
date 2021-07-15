//
//  SearchViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/06/25.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: Constants
    let searchContainerView = UIView()
    
    let searchTextField = UITextField().then {
        $0.placeholder = "주식명,뉴스명,태그 검색"
        $0.backgroundColor = .grey8
        
        $0.leftView = UIImageView(image: UIImage(named: "icSearch"))
        $0.leftViewMode = .always
    }
    
    let searchCancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = .spoqaHanSans(size: 14, style: .Regular)
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
    
    let searchTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        for _ in 0..<10 {
            let button = UIButton().then {
                $0.setTitle("#Test", for: .normal)
                $0.setTitleColor(UIColor.black2, for: .normal)
                $0.titleLabel?.font = UIFont.spoqaHanSans(size: 10, style: .Regular)
                $0.backgroundColor = .tag2
                $0.layer.cornerRadius = 12
                $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            }
            tagStackView.addArrangedSubview(button)
        }
        
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchContainerView)
        searchContainerView.addSubview(searchTextField)
        searchContainerView.addSubview(searchCancelButton)
        
        view.addSubview(tagContainerView)
        tagContainerView.addSubview(tagScrollView)
        tagScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(tagStackView)
        
        view.addSubview(searchTableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        searchContainerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(searchContainerView).offset(20)
            make.right.equalTo(searchCancelButton.snp.left).offset(-15)
            make.centerY.equalTo(searchContainerView)
            make.height.equalTo(36)
        }
        
        searchCancelButton.snp.makeConstraints { make in
            make.right.equalTo(searchContainerView).offset(-20)
            make.centerY.equalTo(searchContainerView)
        }
        
        tagContainerView.snp.makeConstraints { make in
            make.top.equalTo(searchContainerView.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        tagScrollView.snp.makeConstraints { make in
            make.bottom.equalTo(tagContainerView).offset(-16)
            make.centerX.equalTo(tagContainerView)
            make.width.equalTo(tagContainerView).offset(-30)
            make.height.equalTo(20)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.right.equalTo(tagScrollView)
            make.height.equalTo(tagScrollView)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(tagContainerView.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        super.updateViewConstraints()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.searchTextLabel.text = "\(indexPath.row)"
        
        return cell
    }
}
