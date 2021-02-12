//
//  WriteTradingLogViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/31.
//

import UIKit
import FSPagerView
import RxSwift

class WriteTradingLogViewController: UIViewController {

    // MARK: Constants
    // NavigationBar
    let navigationTitleLabel = UILabel().then {
        $0.text = "매매일지 작성"
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let divisionLine = UIView().then {
        $0.backgroundColor = UIColor.grey6
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView().then {
        $0.backgroundColor = .green
    }
    
    let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Title, Tag, Date ContainerView
    let titleContainerView = UIView()
    
    let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = UIColor.grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let titleTextField = UITextField().then {
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.borderStyle = .none
        $0.placeholder = "제목을 입력해주세요"
    }
    
    let tagContainerView = UIView()
    
    let tagLabel = UILabel().then {
        $0.text = "태그"
        $0.textColor = UIColor.grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let dateContainerView = UIView()
    
    let dateLabel = UILabel().then {
        $0.text = "날짜"
        $0.textColor = UIColor.grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let dateContentLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:42"
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    // TradingShare ContainerView
    let tradingShareContainerView = UIView().then {
        $0.backgroundColor = UIColor.grey8
    }
    
    let tradingShareTitleLabel = UILabel().then {
        $0.text = "거래주식"
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let tradingShareAddButton = UIButton().then {
        let buttonimage = UIImage(named: "icAdd")
        $0.setImage(buttonimage, for: .normal)
        $0.setImage(buttonimage, for: .highlighted)
    }
    
    let tradingSharePageView = FSPagerView()
    
    let tradingSharePageControl = FSPageControl().then {
        $0.numberOfPages = 5
        $0.currentPage = 0
        $0.setStrokeColor(UIColor.grey5, for: .normal)
        $0.setFillColor(UIColor.mainColor, for: .selected)
        $0.itemSpacing = 10
        $0.interitemSpacing = 7
    }
    
    // Aticle ContainerView
    let articleContainerView = UIView().then {
        $0.backgroundColor = UIColor.grey8
    }
    
    let articleShareTitleLabel = UILabel().then {
        $0.text = "관련기사"
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let articleAddButton = UIButton().then {
        let buttonimage = UIImage(named: "icAdd")
        $0.setImage(buttonimage, for: .normal)
        $0.setImage(buttonimage, for: .highlighted)
    }
    
    let articlePageView = FSPagerView()
    
    let articlePageControl = FSPageControl().then {
        $0.numberOfPages = 3
        $0.currentPage = 0
        $0.setStrokeColor(UIColor.grey5, for: .normal)
        $0.setFillColor(UIColor.mainColor, for: .selected)
        $0.itemSpacing = 10
        $0.interitemSpacing = 7
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // Memo ContainerView
    let memoContainerView = UIView().then {
        $0.backgroundColor = UIColor.grey8
    }
    
    let memoTitleLabel = UILabel().then {
        $0.text = "메모"
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let memoTextView = UITextView()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        tradingSharePageView.delegate = self
        tradingSharePageView.dataSource = self
        tradingSharePageView.register(TradingSharePagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        articlePageView.delegate = self
        articlePageView.dataSource = self
        articlePageView.register(ArticlePagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        tradingShareAddButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.tradingShareAddBtnTouched()
            }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setBottomLine()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationTitleLabel)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        view.addSubview(divisionLine)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(titleTextField)

        contentStackView.addArrangedSubview(tagContainerView)
        tagContainerView.addSubview(tagLabel)

        contentStackView.addArrangedSubview(dateContainerView)
        dateContainerView.addSubview(dateLabel)
        dateContainerView.addSubview(dateContentLabel)
        
        contentStackView.addArrangedSubview(tradingShareContainerView)
        tradingShareContainerView.addSubview(tradingShareTitleLabel)
        tradingShareContainerView.addSubview(tradingShareAddButton)
        tradingShareContainerView.addSubview(tradingSharePageView)
        tradingShareContainerView.addSubview(tradingSharePageControl)
        
        contentStackView.addArrangedSubview(articleContainerView)
        articleContainerView.addSubview(articleShareTitleLabel)
        articleContainerView.addSubview(articleAddButton)
        articleContainerView.addSubview(articlePageView)
        articleContainerView.addSubview(articlePageControl)
        
        contentStackView.addArrangedSubview(memoContainerView)
        memoContainerView.addSubview(memoTitleLabel)
        memoContainerView.addSubview(memoTextView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.centerX.equalTo(view)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(navigationTitleLabel)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(navigationTitleLabel)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
        
        divisionLine.snp.makeConstraints { make in
            make.top.equalTo(navigationTitleLabel.snp.bottom).offset(12)
            make.left.right.equalTo(view)
            make.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(divisionLine.snp.bottom)
            make.bottom.left.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(scrollView)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
            
        titleContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleContainerView)
            make.left.equalTo(titleContainerView).offset(20)
        }

        titleTextField.snp.makeConstraints { make in
            make.centerY.equalTo(titleContainerView)
            make.left.equalTo(titleLabel.snp.right).offset(60)
            make.right.lessThanOrEqualTo(titleContainerView).offset(-20)
        }

        tagContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        tagLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tagContainerView)
            make.left.equalTo(tagContainerView).offset(20)
        }

        dateContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateContainerView)
            make.left.equalTo(dateContainerView).offset(20)
        }

        dateContentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateContainerView)
            make.left.equalTo(dateLabel.snp.right).offset(60)
            make.right.lessThanOrEqualTo(dateContainerView).offset(-20)
        }
        
        tradingShareContainerView.snp.makeConstraints { make in
            make.height.equalTo(340)
        }
        
        tradingShareTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingShareContainerView).offset(36)
            make.left.equalTo(tradingShareContainerView).offset(20)
        }
        
        tradingShareAddButton.snp.makeConstraints { make in
            make.top.equalTo(tradingShareContainerView).offset(25)
            make.right.equalTo(tradingShareContainerView).offset(-10)
            make.width.height.equalTo(40)
        }
        
        tradingSharePageView.snp.makeConstraints { make in
            make.top.equalTo(tradingShareTitleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(tradingShareContainerView)
            make.height.equalTo(230)
        }
        
        tradingSharePageControl.snp.makeConstraints { make in
            make.left.right.equalTo(tradingShareContainerView)
            make.bottom.equalTo(tradingShareContainerView).offset(-2)
            make.height.equalTo(10)
        }
        
        articleContainerView.snp.makeConstraints { make in
            make.height.equalTo(340)
        }
        
        articleShareTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(articleContainerView).offset(36)
            make.left.equalTo(articleContainerView).offset(20)
        }
        
        articleAddButton.snp.makeConstraints { make in
            make.top.equalTo(articleContainerView).offset(25)
            make.right.equalTo(articleContainerView).offset(-10)
            make.width.height.equalTo(40)
        }
        
        articlePageView.snp.makeConstraints { make in
            make.top.equalTo(articleShareTitleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(articleContainerView)
            make.height.equalTo(230)
        }
        
        articlePageControl.snp.makeConstraints { make in
            make.left.right.equalTo(articleContainerView)
            make.bottom.equalTo(articleContainerView).offset(-2)
            make.height.equalTo(10)
        }
        
        memoContainerView.snp.makeConstraints { make in
            make.height.equalTo(340)
        }
        
        memoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(memoContainerView).offset(36)
            make.left.equalTo(memoContainerView).offset(20)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(memoTitleLabel.snp.bottom).offset(15)
            make.left.right.bottom.equalTo(memoContainerView)
        }
        
        super.updateViewConstraints()
    }
    
    func setBottomLine() {
        titleContainerView.addBottomLine()
        tagContainerView.addBottomLine()
        dateContainerView.addBottomLine()
    }
    
    func tradingShareAddBtnTouched() {
        let addTradingShareVC = AddTradingShareViewController()
        present(addTradingShareVC, animated: true, completion: nil)
    }
}

extension WriteTradingLogViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if pagerView === tradingSharePageView {
            return 5
        } else {
            return 3
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        if pagerView === tradingSharePageView {
            tradingSharePageControl.currentPage = targetIndex
        } else {
            articlePageControl.currentPage = targetIndex
        }
    }
}
