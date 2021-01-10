//
//  SimplePasswordViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/10.
//

import Then
import UIKit

class SimplePasswordViewController: UIViewController {
    
    var buttonStackView = PasswordKeypadView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(buttonStackView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.4)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        super.updateViewConstraints()
    }
}

