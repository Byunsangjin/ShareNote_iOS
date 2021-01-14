//
//  LoginViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/01.
//

import ReactorKit
import RxSwift
import SnapKit
import Then
import UIKit

class LoginViewController: UIViewController, View {
    
    // MARK: Constants
    let logoImageView = UIImageView().then {
        $0.backgroundColor = .red
    }
    
    lazy var textFieldStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.addArrangedSubview(idTextField)
        $0.addArrangedSubview(pwdTextField)
        
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 4
    }
    
    let idTextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.backgroundColor = .black
    }
    
    let pwdTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.backgroundColor = .red
    }
    
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .gray
    }
    
    let lineView = UIView()
    
    let line = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let orLabel = UILabel().then {
        $0.text = "또는"
        $0.textAlignment = .center
        $0.textColor = .gray
        $0.backgroundColor = .white
    }
    
    lazy var snsLoginStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.addArrangedSubview(appleLoginButton)
        $0.addArrangedSubview(kakaoLoginButton)
        $0.addArrangedSubview(naverLoginButton)
        $0.addArrangedSubview(googleLoginButton)
        
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 4
    }
    
    let appleLoginButton = UIButton().then {
        $0.setTitle("애플", for: .normal)
        $0.backgroundColor = .black
    }
    
    let kakaoLoginButton = UIButton().then {
        $0.setTitle("카카오", for: .normal)
        $0.backgroundColor = .yellow
    }
    
    let naverLoginButton = UIButton().then {
        $0.setTitle("네이버", for: .normal)
        $0.backgroundColor = .green
    }
    
    let googleLoginButton = UIButton().then {
        $0.setTitle("구글", for: .normal)
        $0.backgroundColor = .orange
    }
    
    let registButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.sizeToFit()
    }
    
    let searchPwdButton = UIButton().then {
        $0.setTitle("비밀번호찾기", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.sizeToFit()        
    }
    
    let divisionView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = LoginReactor()
        
        setUI()
    }
    
    func bind(reactor: LoginReactor) {
        // Action
        idTextField.rx.text
            .map { LoginReactor.Action.idTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwdTextField.rx.text
            .map { LoginReactor.Action.pwdTextChaged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.enableLogin }
            .map { $0 ? UIColor.green : UIColor.red }
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        view.addSubview(textFieldStackView)
        view.addSubview(loginButton)

        view.addSubview(lineView)
        lineView.addSubview(line)
        lineView.addSubview(orLabel)

        view.addSubview(snsLoginStackView)
        view.addSubview(registButton)
        view.addSubview(divisionView)
        view.addSubview(searchPwdButton)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(80)
            make.centerX.equalTo(view)
            make.width.equalTo(view.snp.width).offset(-60)
            make.height.equalTo(84)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(12)
            make.centerX.equalTo(view)
            make.width.equalTo(textFieldStackView.snp.width)
            make.height.equalTo(40)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom)
            make.centerX.equalTo(view)
            make.width.equalTo(loginButton.snp.width)
            make.height.equalTo(60)
        }

        line.snp.makeConstraints { make in
            make.center.equalTo(lineView)
            make.width.equalTo(lineView.snp.width)
            make.height.equalTo(1)
        }
        
        orLabel.snp.makeConstraints { make in
            make.center.equalTo(lineView)
            make.width.equalTo(100)
        }

        snsLoginStackView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.centerX.equalTo(view)
            make.width.equalTo(lineView.snp.width)
            make.height.equalTo(172)
        }
        
        divisionView.snp.makeConstraints { make in
            make.top.equalTo(snsLoginStackView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.width.equalTo(1)
            make.height.equalTo(registButton.snp.height)
        }
        
        registButton.snp.makeConstraints { make in
            make.right.equalTo(divisionView.snp.left).offset(-10)
            make.centerY.equalTo(divisionView)
        }
        
        searchPwdButton.snp.makeConstraints { make in
            make.left.equalTo(divisionView.snp.right).offset(10)
            make.centerY.equalTo(divisionView)
        }
        
        super.updateViewConstraints()
    }
    
    func showErrorMsg(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
