//
//  AppDelegate.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/03.
//

import UIKit
import RxKakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin
import Firebase
import GoogleSignIn
import AuthenticationServices
import SwiftyBeaver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SwiftyBeaver.addDestination(ConsoleDestination())
        
        if #available(iOS 13, *) {
            SwiftyBeaver.verbose("set in SceneDelegate")
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            appCoordinator = AppCoordinator(window: window)
            appCoordinator?.start()
        }
        
        // KaKao
        RxKakaoSDKCommon.initSDK(appKey: KAKAO_NATIVE_KEY)
        
        // Naver
        let naverInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        naverInstance?.isNaverAppOauthEnable = true
        naverInstance?.isInAppOauthEnable = true
        naverInstance?.isOnlyPortraitSupportedInIphone()
        naverInstance?.serviceUrlScheme = NAVER_SERVICE_URL_SCHEME
        naverInstance?.consumerKey = NAVER_CONSUMER_KEY
        naverInstance?.consumerSecret = NAVER_CONSUMER_SECRET_KEY
        naverInstance?.appName = NAVER_APP_NAME
        
        // Google
        FirebaseApp.configure()
        
        // Apple
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: "로그인에 사용한 User Identifier") { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid.
                    print("해당 ID는 연동되어있습니다.")
                case .revoked:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("해당 ID는 연동되어있지않습니다.")
                case .notFound:
                    // The Apple ID credential is either was not found, so show the sign-in UI.
                    print("해당 ID를 찾을 수 없습니다.")
                default:
                    break
                }
            }
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        } else {
            return GIDSignIn.sharedInstance().handle(url)
        }
        
        return false
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
