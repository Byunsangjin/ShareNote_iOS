//
//  AddTradingShareViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/05.
//

import UIKit

class AddTradingShareViewController: UIViewController {

    // MARK: Constants
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
}
