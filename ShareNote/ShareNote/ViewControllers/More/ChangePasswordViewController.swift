//
//  ChangePasswordViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/07.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    let navigationView = NavigationView().then {
        $0.titleLabel.text = "비밀번호변경"
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
}
