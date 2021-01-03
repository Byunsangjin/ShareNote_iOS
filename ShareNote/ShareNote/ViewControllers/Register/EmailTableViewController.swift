//
//  EmailTableViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/03.
//

import PanModal
import UIKit

class EmailTableViewController: UIViewController {
    
    // MARK: Methods
    override func viewDidLoad() {
        self.view.backgroundColor = .red
    }
}

extension EmailTableViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(self.view.frame.height / 2)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}
