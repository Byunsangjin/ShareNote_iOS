//
//  TradingLogMainViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/21.
//

import FSCalendar
import RxSwift
import Then
import UIKit

class TradingLogMainViewController: UIViewController {
    
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "매매일지"
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let viewHoneyPageButton = UIButton().then {
        $0.setImage(UIImage(named: "iconHoney"), for: .normal)
    }
    
    let editButton = UIButton().then {
        $0.setImage(UIImage(named: "icEdit"), for: .normal)
    }
    
    let divisionLine = UIView().then {
        $0.backgroundColor = UIColor.grey6
    }
    
    let yearMonthContainerView = UIView()
    
    let yearMonthLabel = UILabel().then {
        $0.font = UIFont.spoqaHanSans(size: 20)
        $0.text = "Year.Month"
    }
    
    let yearMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "icArrowDown"), for: .normal)
    }
    
    let calendarView = FSCalendar()
    
    let foldButton = UIButton().then {
        $0.setImage(UIImage(named: "icArrowDown"), for: .normal)
    }
    
    let datePickerContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let datePicker = YearMonthPickerView()
    
    let datePickerSelectButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.red, for: .normal)
    }
    
    let tradingLogTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = UIColor.grey8
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        initCalendar()
        initTableView()
        
        yearMonthButton.rx.tap
            .bind { [weak self] in
                self?.yearMonthBtnTouched()
            }.disposed(by: disposeBag)
        
        foldButton.rx.tap
            .bind { [weak self] in
                self?.foldBtnTouched()
            }.disposed(by: disposeBag)
        
        editButton.rx.tap
            .bind { [weak self] in
                let writeTradingLogVC = WriteTradingLogViewController()
                self?.present(writeTradingLogVC, animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    func yearMonthBtnTouched() {
        
    }
    
    func foldBtnTouched() {
        if calendarView.scope == .month {
            calendarView.setScope(.week, animated: true)
        } else {
            calendarView.setScope(.month, animated: true)
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "매매일지", image: UIImage(named: "icBarWrite"), selectedImage: UIImage(named: "icBarWriteSelect"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        let currentYearMonthString = calendarView.currentPage.getYearMonthString()
        yearMonthLabel.text = currentYearMonthString
    }
    
    func initTableView() {
        tradingLogTableView.dataSource = self
        tradingLogTableView.delegate = self
        
        tradingLogTableView.register(TradingLogTableViewCell.self, forCellReuseIdentifier: "TradingLogTableViewCell")
        tradingLogTableView.register(TradingNoneTableViewCell.self, forCellReuseIdentifier: "TradingNoneTableViewCell")
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
        view.addSubview(foldButton)
        
        view.addSubview(datePickerContainerView)
        datePickerContainerView.addSubview(datePicker)
        datePickerContainerView.addSubview(datePickerSelectButton)
        
        view.addSubview(tradingLogTableView)
        
        view.setNeedsUpdateConstraints()
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
        
        foldButton.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom)
            make.centerX.equalTo(view)
            make.height.equalTo(20)
        }
        
        datePickerContainerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(300)
        }
        
        datePickerSelectButton.snp.makeConstraints { make in
            make.top.right.equalTo(datePickerContainerView)
            make.height.equalTo(20)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(datePickerSelectButton.snp.bottom)
            make.left.right.bottom.equalTo(datePickerContainerView)
        }
        
        tradingLogTableView.snp.makeConstraints { make in
            make.top.equalTo(foldButton.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        super.updateViewConstraints()
    }
}

extension TradingLogMainViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let selectedCell = calendar.cell(for: date, at: monthPosition) else {
            return
        }
        
        let imageView = UIImageView(image: UIImage(named: "icCalendarToday"))
        
        let dx = CGFloat(selectedCell.titleLabel.frame.width - 35) / 2.0
        let dy = CGFloat(selectedCell.titleLabel.frame.height - 30) / 2.0
        
        selectedCell.selectedBackgroundView = imageView
        selectedCell.selectedBackgroundView?.frame = CGRect(x: dx, y: dy, width: 35, height: 30)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        let height = calendar.scope == .month ? 329 : 80
        calendarView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        
        self.view.layoutIfNeeded()
    }
}

extension TradingLogMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            if let _cell = tableView.dequeueReusableCell(withIdentifier: "TradingNoneTableViewCell") as? TradingNoneTableViewCell {
                cell = _cell
            }
        case 1:
            if let _cell = tableView.dequeueReusableCell(withIdentifier: "TradingLogTableViewCell") as? TradingLogTableViewCell {
                cell = _cell
            }
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        
        switch indexPath.row {
        case 0:
            height = 123
        case 1:
            height = 92
        default:
            break
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            // Call edit action
            // Reset state
            success(true)
        })
        editAction.backgroundColor = UIColor.grey8
        editAction.image = UIImage(named: "icCellEdit")
        
        let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            // Call edit action
            // Reset state
            success(true)
        })
        deleteAction.backgroundColor = UIColor.grey8
        deleteAction.image = UIImage(named: "icMainTrash")
        
        let configuration = UISwipeActionsConfiguration(actions:[deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
}
