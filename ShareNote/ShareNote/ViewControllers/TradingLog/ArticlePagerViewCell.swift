//
//  ArticlePagerViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/04.
//

import FSPagerView
import UIKit

class ArticlePagerViewCell: FSPagerViewCell {
    
    // MARK: Constants
    let containerView = UIView.createTradingShareCellView()
    
    let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = UIColor.grey6
    }
    
    let titleContainerView = UIView()
    
    let newpaperLabel = UILabel().then {
        $0.text = "스타뉴스"
        $0.font = UIFont.spoqaHanSans(size: 10, style: .Regular)
        $0.textColor = UIColor.grey2
        $0.numberOfLines = 0
    }
    
    let headlineLabel = UILabel().then {
        $0.text = "주식 엄청난 수익률 당설해 출연료 안받아도 된다 한 연예인"
        $0.font = UIFont.spoqaHanSans(size: 14)
        $0.textColor = UIColor.black2
        $0.numberOfLines = 0
    }
    
    let articleContentLabel = UILabel().then {
        $0.text = "비용전가 미 38개주 구글반독점 소송가세소비자에게 비용전가 미 38개주 구글 반독점 소송가세소비자에게 비용 전가미 38개주 구글 반독점 소송가세 소송가세소게 비용 전가미 38개주 구글 반독점 소송가세 소송가세38개주 구글반독점 소송가세소비자에게 비용전가 미 38개주 구글 반독점 소송가세소비자에게 비용 전가미 38개주 구글 반독점 소송가세 소송가세소게 비용 전가미 38개주 구글 반독점 소송가세 소송가"
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
        $0.textColor = UIColor.grey1
        $0.numberOfLines = 0
    }
    
    let editButton = UIButton().then {
        $0.setTitle("기사 본문 보기", for: .normal)
        $0.setTitleColor(UIColor.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "icMainTrash"), for: .normal)
        $0.setImage(UIImage(named: "icMainTrash"), for: .highlighted)
    }
    
    // MARK: Variables
    var isShowButtons = true
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        self.contentView.layer.shadowRadius = 0
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(thumbnailImageView)
        
        containerView.addSubview(titleContainerView)
        titleContainerView.addSubview(newpaperLabel)
        titleContainerView.addSubview(headlineLabel)
        
        containerView.addSubview(articleContentLabel)
        
        if (isShowButtons) {
            containerView.addSubview(editButton)
            containerView.addSubview(deleteButton)
        }
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(1.5)
            make.bottom.equalTo(contentView).offset(-1.5)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(15)
            make.left.equalTo(containerView).offset(20)
            make.width.equalTo(90)
            make.height.equalTo(60)
        }
        
        titleContainerView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView)
            make.left.equalTo(thumbnailImageView.snp.right).offset(14)
            make.right.equalTo(containerView).offset(-26)
            make.height.equalTo(60)
        }
        
        newpaperLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(titleContainerView)
            make.height.equalTo(12)
        }
        
        headlineLabel.snp.makeConstraints { make in
            make.top.equalTo(newpaperLabel.snp.bottom).offset(5)
            make.left.right.bottom.equalTo(titleContainerView)
        }
        
        articleContentLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(15)
            make.left.equalTo(containerView).offset(20)
            make.right.equalTo(containerView).offset(-26)
            make.height.equalTo(74)
        }
        
        if (isShowButtons) {
            editButton.snp.makeConstraints { make in
                make.left.bottom.equalTo(containerView)
                make.width.equalTo(248)
                make.height.equalTo(45)
            }
            
            deleteButton.snp.makeConstraints { make in
                make.right.bottom.equalTo(containerView)
                make.left.equalTo(editButton.snp.right)
                make.height.equalTo(45)
            }
        }
        
        super.updateConstraints()
    }
}
