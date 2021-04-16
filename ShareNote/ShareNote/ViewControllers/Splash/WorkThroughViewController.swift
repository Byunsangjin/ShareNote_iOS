//
//  WorkThroughViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/04/16.
//

import FSPagerView
import UIKit

class WorkThroughViewController: UIViewController {

    // MARK: Constants
    let pagerView = FSPagerView()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(WorkThroughImageCell.self, forCellWithReuseIdentifier: "WorkThroughImageCell")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(pagerView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        pagerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.centerX.equalTo(view)
            make.width.equalTo(375)
            make.height.equalTo(210)
        }
        
        super.updateViewConstraints()
    }
}

extension WorkThroughViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 4
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "WorkThroughImageCell", at: index) as? WorkThroughImageCell else {
            return FSPagerViewCell()
        }
        
        let image = UIImage(named: "icIllust0\(index + 1)")
        cell.imageView?.image = image
        
        return cell
    }
}
