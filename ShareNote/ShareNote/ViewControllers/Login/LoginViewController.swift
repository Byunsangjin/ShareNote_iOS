//
//  LoginViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/01.
//

import AuthenticationServices
import Firebase
import GoogleSignIn
import KakaoSDKAuth
import NaverThirdPartyLogin
import ReactorKit
import RxKakaoSDKAuth
import RxSwift
import SkyFloatingLabelTextField
import SnapKit
import Then
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Constants
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView()
    
    let titleLabel = UILabel().then {
        $0.text = "건강한 주식투자를\n시작해볼까요?"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 24, style: .Regular)
        $0.numberOfLines = 0
    }
    
    let passwordContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let passwordTextField = SkyFloatingLabelTextField.createTextField(placeholder: "비밀번호를 입력해주세요").then {
        $0.title = "비밀번호 입력"
    }

    let findPasswordButton = UIButton().then {
        let attributeString = NSAttributedString(string: "비밀번호가 기억나지 않습니다.",
                                                 attributes: [NSAttributedString.Key.font : UIFont.spoqaHanSans(size: 12, style: .Regular),
                                                              NSAttributedString.Key.foregroundColor : UIColor.grey4,
                                                              NSAttributedString.Key.underlineStyle : true,
                                                              NSAttributedString.Key.underlineColor : UIColor.grey4])
        $0.setAttributedTitle(attributeString, for: .normal)
        $0.isHidden = true
    }
    
    let idContainerView = UIView()
    
    let idTextField = SkyFloatingLabelTextField.createTextField(placeholder: "아이디를 입력해주세요.").then {
        $0.title = "아이디 입력"
    }
    
    let findIdButton = UIButton().then {
        let attributeString = NSAttributedString(string: "아이디가 기억나지 않습니다.",
                                                 attributes: [NSAttributedString.Key.font : UIFont.spoqaHanSans(size: 12, style: .Regular),
                                                              NSAttributedString.Key.foregroundColor : UIColor.grey4,
                                                              NSAttributedString.Key.underlineStyle : true,
                                                              NSAttributedString.Key.underlineColor : UIColor.grey4])
        $0.setAttributedTitle(attributeString, for: .normal)
        $0.isHidden = true
    }
    
    let divideLineView = UIView().then {
        $0.backgroundColor = .grey5
    }
    
    let divideLabel = UILabel().then {
        $0.text = "간편 로그인"
        $0.textColor = .grey5
        $0.font = UIFont.spoqaHanSans(size: 12)
        $0.textAlignment = .center
        
        $0.backgroundColor = .white
    }
    
    let simpleLoginStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let naverLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "iconLoginNaver"), for: .normal)
    }
    
    let kakaoLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "iconLoginKakao"), for: .normal)
    }
    
    let googleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "iconLoginGoogle"), for: .normal)
    }
    
    let appleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "iconLoginApple"), for: .normal)
    }
    
    let orLabel = UILabel().then {
        $0.text = "or"
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let registerButton = UIButton().then {
        let attributeString = NSAttributedString(string: "쉐어노트 회원가입하기",
                                                 attributes: [NSAttributedString.Key.font : UIFont.spoqaHanSans(size: 12, style: .Regular),
                                                              NSAttributedString.Key.foregroundColor : UIColor.grey4,
                                                              NSAttributedString.Key.underlineStyle : true,
                                                              NSAttributedString.Key.underlineColor : UIColor.grey4])
        $0.setAttributedTitle(attributeString, for: .normal)
    }
    
    let keyboardFloatingView = UIView().then {
        $0.isHidden = true
    }
    
    let moveButtonContainerView = UIView().then {
        $0.backgroundColor = .whiteTwo
        $0.isHidden = true
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.backgroundColor = .whiteTwo
//        $0.isHidden = true
    }
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    var keyboardFloatingViewBottom: Constraint?
    
    var idContainerTopConstraint: Constraint?
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setKeyboardNotification()
        
        simpleLoginStackView.addArrangedSubview(naverLoginButton)
        simpleLoginStackView.addArrangedSubview(kakaoLoginButton)
        simpleLoginStackView.addArrangedSubview(googleLoginButton)
        simpleLoginStackView.addArrangedSubview(appleLoginButton)
        
        cancelButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] in
                self?.passwordContainerView.isHidden = false
                self?.passwordTextField.becomeFirstResponder()
                self?.idContainerTopConstraint?.update(offset: 120)
            }.disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind { [weak self] in
                self?.presentMainTabViewController()
            }.disposed(by: disposeBag)
        
        idTextField.rx.controlEvent([.editingDidBegin])
            .bind { [weak self] in
                self?.findIdButton.isHidden = false
            }.disposed(by: disposeBag)
        
        idTextField.rx.controlEvent([.editingDidEnd])
            .bind { [weak self] in
                self?.findIdButton.isHidden = true
            }.disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent([.editingDidBegin])
            .bind { [weak self] in
                self?.findPasswordButton.isHidden = false
            }.disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent([.editingDidEnd])
            .bind { [weak self] in
                self?.findPasswordButton.isHidden = true
            }.disposed(by: disposeBag)
        
        self.scrollContentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contentViewTouched)))
        
        naverLoginInstance?.delegate = self
        
        naverLoginButton.rx.tap
            .bind { [weak self] in
                self?.naverLoginInstance?.requestThirdPartyLogin()
            }.disposed(by: disposeBag)
        
        kakaoLoginButton.rx.tap
            .bind { [weak self] in
                self?.kakaoLoginBtnTouched()
            }.disposed(by: disposeBag)
                
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        googleLoginButton.rx.tap
            .bind { _ in
                GIDSignIn.sharedInstance()?.signIn()
            }.disposed(by: disposeBag)
        
        
        if #available(iOS 13.0, *) {
            appleLoginButton.rx.tap
                .bind { [weak self] in
                    let appleIDProvider = ASAuthorizationAppleIDProvider()
                    let request = appleIDProvider.createRequest()
                    request.requestedScopes = [.fullName, .email]
                    
                    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                    authorizationController.delegate = self
                    authorizationController.presentationContextProvider = self
                    authorizationController.performRequests()
                }.disposed(by: disposeBag)
        }
        
        registerButton.rx.tap
            .bind { [weak self] in
                let registerViewController = RegisterViewController()
                registerViewController.modalPresentationStyle = .fullScreen
                self?.present(registerViewController, animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(titleLabel)
        
        scrollContentView.addSubview(passwordContainerView)
        passwordContainerView.addSubview(passwordTextField)
        passwordContainerView.addSubview(findPasswordButton)
        
        scrollContentView.addSubview(idContainerView)
        idContainerView.addSubview(idTextField)
        idContainerView.addSubview(findIdButton)
        
        scrollContentView.addSubview(divideLineView)
        scrollContentView.addSubview(divideLabel)
        
        scrollContentView.addSubview(simpleLoginStackView)
        
        scrollContentView.addSubview(orLabel)
        scrollContentView.addSubview(registerButton)
        
        scrollContentView.addSubview(keyboardFloatingView)
        keyboardFloatingView.addSubview(moveButtonContainerView)
        moveButtonContainerView.addSubview(cancelButton)
        moveButtonContainerView.addSubview(nextButton)
        keyboardFloatingView.addSubview(loginButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(763)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(118)
            make.left.equalTo(scrollContentView).offset(20)
            make.right.equalTo(scrollContentView).offset(-20)
        }
        
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(90)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView)
            make.left.right.equalTo(passwordContainerView)
            make.height.equalTo(60)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.left.equalTo(passwordContainerView)
        }
        
        idContainerView.snp.makeConstraints { make in
            idContainerTopConstraint = make.top.equalTo(passwordContainerView).offset(0).constraint
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(90)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idContainerView)
            make.left.right.equalTo(idContainerView)
            make.height.equalTo(60)
        }

        findIdButton.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(5)
            make.left.equalTo(idContainerView)
        }
        
        divideLineView.snp.makeConstraints { make in
            make.bottom.equalTo(scrollContentView.snp.bottom).offset(-245)
            make.left.equalTo(scrollContentView).offset(20)
            make.right.equalTo(scrollContentView).offset(-20)
            make.height.equalTo(1)
        }
        
        divideLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(divideLineView)
            make.width.equalTo(98)
        }
        
        simpleLoginStackView.snp.makeConstraints { make in
            make.top.equalTo(divideLabel.snp.bottom).offset(35)
            make.centerX.equalTo(scrollContentView)
            make.width.equalTo(220)
            make.height.equalTo(40)
        }
        
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(simpleLoginStackView.snp.bottom).offset(30)
            make.centerX.equalTo(scrollContentView)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.centerX.equalTo(scrollContentView)
        }
        
        keyboardFloatingView.snp.makeConstraints { make in
            make.left.right.equalTo(scrollContentView)
            keyboardFloatingViewBottom = make.bottom.equalTo(view).constraint
            make.height.equalTo(45)
        }
        
        moveButtonContainerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(keyboardFloatingView)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(moveButtonContainerView).offset(20)
            make.centerY.equalTo(moveButtonContainerView)
        }
        
        nextButton.snp.makeConstraints { make in
            make.right.equalTo(moveButtonContainerView).offset(-20)
            make.centerY.equalTo(moveButtonContainerView)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(keyboardFloatingView)
        }
        
        super.updateViewConstraints()
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.keyboardFloatingView.isHidden = false
        self.moveButtonContainerView.isHidden = !idTextField.isFirstResponder
        self.loginButton.isHidden = !passwordTextField.isFirstResponder
        
        self.keyboardFloatingViewBottom?.update(offset: -keyboardFrame.size.height)
        self.keyboardFloatingView.updateConstraints()
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        
        scrollView.isScrollEnabled = false
        
        setTextFieldContentOffset()
    }
    
    func setTextFieldContentOffset() {
        if idTextField.isFirstResponder {
            if idContainerView.frame.origin.y + 100 > keyboardFloatingView.frame.origin.y {
                let y = idContainerView.frame.origin.y + 100 - keyboardFloatingView.frame.origin.y
                scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
            }
        } else if passwordTextField.isFirstResponder {
            
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        scrollView.isScrollEnabled = true
        keyboardFloatingView.isHidden = true
        keyboardFloatingViewBottom?.update(offset: 0)
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    @objc
    func contentViewTouched() {
        self.scrollContentView.endEditing(true)
    }
    
    func presentMainTabViewController() {
        let mainTabBarViewController = MainTabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = mainTabBarViewController
    }
    
    func kakaoLoginBtnTouched() {
        if (AuthApi.isKakaoTalkLoginAvailable()) {
            AuthApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext:{ [weak self] (oauthToken) in
                    logger.verbose("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    self?.presentMainTabViewController()
                }, onError: {error in
                    logger.verbose(error)
                })
                .disposed(by: disposeBag)
        }
    }
}

extension LoginViewController : NaverThirdPartyLoginConnectionDelegate {
    // 로그인 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        self.presentMainTabViewController()
    }
        
    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        self.presentMainTabViewController()
    }
    
    // 로그아웃 할 경우 호출 (토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        naverLoginInstance?.requestDeleteToken()
    }
    
    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        logger.verbose("didSignInFor")
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        logger.verbose("didDisconnectWith")
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:

            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
            presentMainTabViewController()
        default:
            break
        }
    }

    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
