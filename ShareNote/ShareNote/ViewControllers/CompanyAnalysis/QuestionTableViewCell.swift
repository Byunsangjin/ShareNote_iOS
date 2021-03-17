//
//  QuestionTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/16.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    // MARK: Constants
    let containerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let titleLabel = UILabel().then {
        $0.text = "시가총액은 얼마인가요?"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let checkImageView = UIImageView().then {
        $0.image = UIImage(named: "checkN")
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
        containerView.addSubview(checkImageView)
                
        contentView.setNeedsUpdateConstraints()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        changeLayer()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(15)
            make.right.equalTo(checkImageView.snp.left).offset(-15)
            make.centerY.equalTo(containerView)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.right.equalTo(containerView).offset(-15)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(20)
        }
        
        super.updateConstraints()
    }
    
    func changeLayer() {
        containerView.layer.addBorder([.left, .right], color: .whiteTwo, width: 1)
    }
}
