//
//  QuestionConfirmViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/17.
//

import UIKit
import SnapKit

class QuestionConfirmViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "질문 확인하기"
    }
    
    let titleView = UIView.createTradingShareCellView().then {
        $0.backgroundColor = .grey6
    }
    
    let titleLabel = UILabel().then {
        $0.text = "선택한 질문 갯수"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let selectedQuestionCountLabel = UILabel().then {
        $0.text = "4개"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let selectedQuestionTableView = UITableView()
    
    let createQuestionButton = UIButton().then {
        $0.backgroundColor = .white
        
        $0.layer.cornerRadius = 7
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainColor.cgColor
        $0.layer.applySketchShadow(color: .black1, alpha: 0.05, x: 0, y: 1, blur: 10, spread: 0)
    }
    
    let okButton = UIButton().then {
        $0.setTitle("질문 작성하기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
    }
    
    var height: Constraint?
    
    var count = 3
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        selectedQuestionTableView.delegate = self
        selectedQuestionTableView.dataSource = self
        
        selectedQuestionTableView.register(QuestionConfirmTableViewCell.self, forCellReuseIdentifier: "QuestionConfirmTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedQuestionTableView.setEditing(true, animated: true)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(selectedQuestionCountLabel)
        
        view.addSubview(selectedQuestionTableView)
        
        view.addSubview(createQuestionButton)
        
        view.addSubview(okButton)
        
        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(37)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleView).multipliedBy(0.85)
            make.centerY.equalTo(titleView)
        }
        
        selectedQuestionCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleView)
            make.left.equalTo(titleLabel.snp.right).offset(19)
        }
        
        selectedQuestionTableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.centerX.equalTo(view)
            make.width.equalTo(titleView)
            height = make.height.equalTo(132).priority(.medium).constraint
            make.bottom.lessThanOrEqualTo(okButton.snp.top).offset(-115).priority(.high)
        }
        
        createQuestionButton.snp.makeConstraints { make in
            make.top.equalTo(selectedQuestionTableView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.width.equalTo(titleView)
            make.height.equalTo(55)
        }
        
        okButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-37)
            make.centerX.equalTo(view)
            make.width.equalTo(titleView)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
}

extension QuestionConfirmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionConfirmTableViewCell") as? QuestionConfirmTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count += 1
        tableView.insertRows(at: [IndexPath(row: indexPath.row + 1, section: 0)], with: .top)
        
//        DispatchQueue.main.async { [weak self] in
            self.height?.update(offset: tableView.contentSize.height)
//        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
}
