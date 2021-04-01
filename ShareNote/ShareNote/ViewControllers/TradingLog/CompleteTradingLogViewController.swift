//
//  CompleteTradingLogViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/11.
//

import UIKit
import RxSwift

class CompleteTradingLogViewController: UIViewController {
    
    // Navigation ContainerView
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "매매일지 작성"
        
        $0.rightBarButton.setTitle("편집", for: .normal)
        $0.rightBarButton.setTitleColor(.black2, for: .normal)
        $0.rightBarButton.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
        
        $0.backgroundColor = .mainColor
        
        $0.borderColor = .clear
    }
    
    // TradingLogTitle ContainerView
    let tradingLogTitleContainerView = UIView().then {
        $0.backgroundColor = UIColor.mainColor
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:43"
        $0.textColor = UIColor.mainBrown
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "기아차 가즈아~~"
        $0.textColor = UIColor.black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
    }
    
    let tagScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView()
    
    let tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let segmentControl = UISegmentedControl(items: ["거래주식", "관련기사", "메모"]).then {
        $0.selectedSegmentIndex = 0
    }
    
    let segmentDivideLineView = UIView().then {
        $0.backgroundColor = UIColor.grey7
    }
    
    static var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    var tradingShareCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = UIColor.grey8
    }
    
    var articleCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = UIColor.grey8
    }
    
    let memoTextView = UITextView().then {
        $0.backgroundColor = .red
    }
    
    let moveTopScrollButton = UIButton().then {
        $0.setImage(UIImage(named: "icTopScroll"), for: .normal)
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        segmentControl.rx.selectedSegmentIndex
            .bind { property in
                self.segmentControl.changeUnderlinePosition()
                self.moveTopScrollButton.isHidden = true
                
                switch property {
                case 0:
                    self.tradingShareCollectionView.isHidden = false
                    self.articleCollectionView.isHidden = true
                    self.memoTextView.isHidden = true
                    break
                case 1:
                    self.tradingShareCollectionView.isHidden = true
                    self.articleCollectionView.isHidden = false
                    self.memoTextView.isHidden = true
                    break
                case 2:
                    self.tradingShareCollectionView.isHidden = true
                    self.articleCollectionView.isHidden = true
                    self.memoTextView.isHidden = false
                    self.moveTopScrollButton.isHidden = false
                    break
                default:
                    break
                }
                
            }.disposed(by: disposeBag)
        
        navigationView.leftBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        navigationView.rightBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        segmentControl.addUnderlineForSelectedSegment()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(tradingLogTitleContainerView)
        tradingLogTitleContainerView.addSubview(dateLabel)
        tradingLogTitleContainerView.addSubview(titleLabel)
        
        for _ in 0..<10 {
            let button = UIButton().then {
                $0.setTitle("#보여지고", for: .normal)
                $0.setTitleColor(UIColor.black2, for: .normal)
                $0.titleLabel?.font = UIFont.spoqaHanSans(size: 10, style: .Regular)
                $0.backgroundColor = UIColor.tag
                $0.layer.cornerRadius = 12
                $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            }
            tagStackView.addArrangedSubview(button)
        }
        
        tradingLogTitleContainerView.addSubview(tagScrollView)
        tagScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(tagStackView)
        
        view.addSubview(segmentControl)
        segmentControl.removeBorder()
        
        view.addSubview(segmentDivideLineView)

        view.addSubview(tradingShareCollectionView)
        tradingShareCollectionView.delegate = self
        tradingShareCollectionView.dataSource = self
        view.addSubview(articleCollectionView)
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        view.addSubview(memoTextView)
        
        view.addSubview(moveTopScrollButton)
        
        tradingShareCollectionView.register(TradingSharePagerViewCell.self, forCellWithReuseIdentifier: "TradingSharePagerViewCell")
        articleCollectionView.register(ArticlePagerViewCell.self, forCellWithReuseIdentifier: "ArticlePagerViewCell")
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        tradingLogTitleContainerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(135)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingLogTitleContainerView.snp.top).offset(34)
            make.left.equalTo(tradingLogTitleContainerView).offset(20)
            make.right.equalTo(tradingLogTitleContainerView).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.equalTo(tradingLogTitleContainerView).offset(20)
            make.right.equalTo(tradingLogTitleContainerView).offset(-20)
        }
        
        tagScrollView.snp.makeConstraints { make in
            make.left.equalTo(tradingLogTitleContainerView).offset(20)
            make.right.bottom.equalTo(tradingLogTitleContainerView).offset(-20)
            make.height.equalTo(20)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.right.equalTo(tagScrollView)
            make.height.equalTo(tagScrollView)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(tradingLogTitleContainerView.snp.bottom)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(50)
        }
        
        segmentDivideLineView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.width.equalTo(view)
            make.height.equalTo(1)
        }
        
        tradingShareCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        articleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        moveTopScrollButton.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        super.updateViewConstraints()
    }
}

extension CompleteTradingLogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case tradingShareCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TradingSharePagerViewCell", for: indexPath) as? TradingSharePagerViewCell else {
                return UICollectionViewCell()
            }
            
            cell.isShowButtons = false
            return cell
        case articleCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticlePagerViewCell", for: indexPath) as? ArticlePagerViewCell else {
                return UICollectionViewCell()
            }
            
            cell.isShowButtons = false
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width

        return CGSize(width: width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 19, left: 0, bottom: 0, right: 0)
    }
}
