//
//  AuthenticationViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/12.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    // MARK: Constants
    let closeButton = UIButton().then {
        $0.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setUI()
    }
    
    func setUI() {
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
}
