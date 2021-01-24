//
//  TradingLogMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import FSCalendar
import Then
import UIKit

class TradingLogMainViewController: UIViewController {
    
    let titleLabel = UILabel().then {
        $0.text = "매매일지"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let viewHoneyPageButton = UIButton().then {
        $0.setImage(UIImage(named: "icMyHoneyPage"), for: .normal)
        $0.setImage(UIImage(named: "icMyHoneyPage"), for: .highlighted)
    }
    
    let editButton = UIButton().then {
        $0.setImage(UIImage(named: "icEdit"), for: .normal)
        $0.setImage(UIImage(named: "icEdit"), for: .highlighted)
    }
    
    let divisionLine = UIView().then {
        $0.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
    }
    
    let yearMonthContainerView = UIView()
    
    let yearMonthLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 21)
        $0.text = "2021.01"
    }
    
    let yearMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "icArrowDown"), for: .normal)
    }
    
    let calendarView = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        initCalendar()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "매매일지", image: UIImage(named: "icBarWrite"), selectedImage: UIImage(named: "icBarWriteSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(viewHoneyPageButton)
        view.addSubview(editButton)
        view.addSubview(divisionLine)
        
        view.addSubview(yearMonthContainerView)
        yearMonthContainerView.addSubview(yearMonthLabel)
        yearMonthContainerView.addSubview(yearMonthButton)
        
        view.addSubview(calendarView)
        
        view.setNeedsUpdateConstraints()
    }
    
    func initCalendar() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.appearance.selectionColor = .none
        calendarView.appearance.todayColor = .none
        
        calendarView.appearance.titleTodayColor = .black
        calendarView.appearance.titleSelectionColor = .black
        
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.headerHeight = 0
        calendarView.scope = .month
        
        logger.verbose(calendarView.currentPage.get(.month, .year, .day).day)
        logger.verbose(calendarView.today?.get(.year, .month, .day).day)
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
        }
        
        viewHoneyPageButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
        
        divisionLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14.5)
            make.left.right.equalTo(view)
            make.height.equalTo(1)
        }
        
        yearMonthContainerView.snp.makeConstraints { make in
            make.top.equalTo(divisionLine.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(52)
        }
        
        yearMonthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearMonthContainerView)
            make.left.equalTo(yearMonthContainerView.snp.left).offset(20)
        }
        
        yearMonthButton.snp.makeConstraints { make in
            make.centerY.equalTo(yearMonthContainerView)
            make.left.equalTo(yearMonthLabel.snp.right).offset(6)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(yearMonthContainerView.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(329)
        }
        
        super.updateViewConstraints()
    }
}

extension TradingLogMainViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let selectedCell = calendar.cell(for: date, at: monthPosition) else {
            return
        }
        
        let image = UIImage(named: "icCalendarSelect")
        selectedCell.selectedBackgroundView = UIImageView(image: image)
    }
    
}
