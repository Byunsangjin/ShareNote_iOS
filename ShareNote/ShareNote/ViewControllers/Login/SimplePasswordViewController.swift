//
//  SimplePasswordViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/10.
//

import SwiftyBeaver
import Then
import UIKit

class SimplePasswordViewController: UIViewController {
    
    var pwdKeypadView = PasswordKeypadView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwdKeypadView.delegate = self
        
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(pwdKeypadView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        
        pwdKeypadView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.4)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        super.updateViewConstraints()
    }
}

extension SimplePasswordViewController: PasswordProtocol {
    func backwardAction() {
        SwiftyBeaver.verbose(#function)
    }
    
    func clearAction() {
        SwiftyBeaver.verbose(#function)
    }
    
    func numberAction(sender: UIButton) {
        SwiftyBeaver.verbose(sender.titleLabel?.text)
    }
}
