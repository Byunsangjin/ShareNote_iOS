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
    
    let pageControl = FSPageControl().then {
        $0.numberOfPages = 4
        $0.currentPage = 0
        $0.setStrokeColor(UIColor.grey5, for: .normal)
        $0.setFillColor(UIColor.mainColor, for: .selected)
        $0.itemSpacing = 7
        $0.interitemSpacing = 8
    }
    
    let startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 4
    }
        
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
        view.addSubview(pageControl)
        
        view.addSubview(startButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        pagerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.centerX.equalTo(view)
            make.width.equalTo(375)
            make.height.equalTo(210)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pagerView.snp.bottom).offset(38)
            make.centerX.equalTo(view)
            make.height.equalTo(10)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(90)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(55)
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
