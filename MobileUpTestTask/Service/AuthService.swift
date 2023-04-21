//
//  AuthService.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 21.04.2023.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldPresent(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFaill()
    func authServiceLogout()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    static let shared = AuthService()
    private let appID = "51622152"
    private var vkSDK: VKSdk
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        vkSDK = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["wall"]
        VKSdk.wakeUpSession(scope) { [delegate] state, error in
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFaill()
            }
        }
    }
    
    func  logout() {
        VKSdk.forceLogout()
        delegate?.authServiceLogout()
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInDidFaill()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldPresent(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(captchaError as Any)
    }
    
}
