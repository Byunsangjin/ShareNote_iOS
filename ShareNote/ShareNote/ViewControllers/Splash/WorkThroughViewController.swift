//
//  WorkThroughViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/04/16.
//

import FSPagerView
import RxSwift
import UIKit

class WorkThroughViewController: UIViewController {

    // MARK: Constants
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView()
    
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
        
    // MARK: Variables
    var titleList = ["Share Note",
                     "기업분석",
                     "매매일지",
                     "북마크 기능"]
    
    var descriptionList = ["쉐어노트와 함께 건강한 주식투자를 시작하세요",
                           "전문가의 관점에서 기업을 분석하고\n다양한 템플릿을 활용해 기업을 분석할 수 있어요",
                           "매매일지를 작성하며 투자의 근거를 되돌아보세요\n정보를 기록하고 관리할 수 있어요",
                           "시장의 이슈를 한눈에, 쉐어노티Pick, 개인투자자가\n주목한 이슈와 관련된 기업을 한 눈에 볼 수 있어요"]
    
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(WorkThroughImageCell.self, forCellWithReuseIdentifier: "WorkThroughImageCell")
        
        startButton.rx.tap
            .bind { [weak self] in
                let loginViewController = LoginViewController()
                loginViewController.modalPresentationStyle = .fullScreen
                self?.present(loginViewController, animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(pagerView)
        scrollContentView.addSubview(pageControl)
        
        scrollContentView.addSubview(startButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.width.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.width.bottom.equalTo(scrollView)
            make.height.equalTo(666)
        }
        
        pagerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(scrollContentView)
            make.height.equalTo(474)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pagerView.snp.bottom).offset(20)
            make.centerX.equalTo(scrollContentView)
            make.height.equalTo(10)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(90)
            make.centerX.equalTo(scrollContentView)
            make.width.equalTo(scrollContentView).offset(-40)
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
        cell.workThroghImageView.image = image
        cell.titleLabel.text = titleList[index]
        cell.descriptionLabel.text = descriptionList[index]
        
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
}
