//
//  CompleteCompanyAnalysisTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/23.
//

import UIKit

class CompleteCompanyAnalysisTableViewCell: UITableViewCell {
    
    // MARK: Constants
    let containerView = UIView.createTradingShareCellView()
    
    let titleLabel = UILabel().then {
        $0.text = "작년 영업이익률은 몇퍼센트였나요?최대"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "반도체, 휴대폰, 생활가전이며 매출의 대부분은 반도체가 차지한다.반도체는 설계와 생산으로 나뉘는데 삼성전자는 설계와 생산을 모두 진행한다."
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.numberOfLines = 0
    }
    
    // MARK: Methods
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
    
    func setUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
                
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-10)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(20)
            make.left.equalTo(containerView).offset(15)
            make.right.equalTo(containerView).offset(-15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(containerView).offset(-20)
        }
        
        super.updateConstraints()
    }
}
