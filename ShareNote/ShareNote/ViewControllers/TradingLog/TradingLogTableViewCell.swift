//
//  TradingLogTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/28.
//

import UIKit

class TradingLogTableViewCell: UITableViewCell {

    // MARK: Constants
    let containerView = UIView.createCellContainerView()
    
    let titleLabel = UILabel().then {
        $0.text = "기아차 10퍼센트 달성하자"
        $0.textColor = UIColor.black2
        $0.font = UIFont.spoqaHanSans(size: 14)
        $0.numberOfLines = 0
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
    
    // MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    func setUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        for _ in 0..<10 {
            let button = UIButton().then {
                $0.setTitle("#Test", for: .normal)
                $0.setTitleColor(UIColor.black2, for: .normal)
                $0.titleLabel?.font = UIFont.spoqaHanSans(size: 10, style: .Regular)
                $0.backgroundColor = UIColor.tag
                $0.layer.cornerRadius = 12
                $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            }
            tagStackView.addArrangedSubview(button)
        }
        
        let button2 = UIButton().then {
            $0.setTitle("#Test 라벨 입니다", for: .normal)
            $0.setTitleColor(UIColor.black2, for: .normal)
            $0.titleLabel?.font = UIFont.spoqaHanSans(size: 10, style: .Regular)
            $0.backgroundColor = UIColor.tag
            $0.layer.cornerRadius = 12
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
        tagStackView.addArrangedSubview(button2)
        
        let button3 = UIButton().then {
            $0.setTitle("#Hi", for: .normal)
            $0.setTitleColor(UIColor.black2, for: .normal)
            $0.titleLabel?.font = UIFont.spoqaHanSans(size: 10, style: .Regular)
            $0.backgroundColor = UIColor.tag
            $0.layer.cornerRadius = 12
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
        tagStackView.addArrangedSubview(button3)
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        
        containerView.addSubview(tagScrollView)
        tagScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(tagStackView)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.left.equalTo(containerView).offset(15)
            make.right.equalTo(containerView).offset(-16)
        }
        
        tagScrollView.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(15)
            make.right.equalTo(containerView).offset(-15)
            make.bottom.equalTo(containerView).offset(-16)
            make.height.equalTo(20)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.right.equalTo(tagScrollView)
            make.height.equalTo(tagScrollView)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
        }
        
        super.updateConstraints()
    }
}
