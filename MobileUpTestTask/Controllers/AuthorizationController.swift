//
//  AuthorizationController.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 21.04.2023.
//

import UIKit
import SnapKit
import VK_ios_sdk

final class AuthorizationController: UIViewController {
    //MARK: - Variables
    private let mobileUpLabel: UILabel = {
       let label = UILabel()
        label.text = "Mobile Up\nGallery"
//        label.font = UIFont(name: "SF Pro Text", size: 44)
        label.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    private let authButton: UIButton = {
       let btn = UIButton()
        btn.setTitle(R.Auth.buttonTitle, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        return btn
    }()
    private var languageSegmented: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Ru", "En"])
        segment.tintColor = .white
        segment.backgroundColor = .lightGray
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    //MARK: - UI Configure
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentReachabilityStatus == .notReachable {
            let alert = UIAlertController(title: R.Error.noInternet)
            present(alert, animated: true)
        }
    }
    
    private func configure() {
        view.backgroundColor = .white
    
        view.addSubview(mobileUpLabel)
        view.addSubview(authButton)
        self.view.addSubview(languageSegmented)
        languageSegmented.addTarget(self, action: #selector(changeLanguage), for: .valueChanged)
        languageSegmented.selectedSegmentIndex = R.isRussian ? 0 : 1
        authButton.addTarget(self, action: #selector(auth), for: .touchUpInside)
    }
    
    private func layout() {
        mobileUpLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(150)
            make.top.equalToSuperview().offset(170)
        }
        authButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-42)
            make.height.equalTo(52)
        }
        languageSegmented.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
}

//MARK: - Action
@objc extension AuthorizationController {
    func auth() {
        AuthService.shared.wakeUpSession()
    }
    
    func changeLanguage() {
        R.isRussian = !R.isRussian
        authButton.setTitle(R.Auth.buttonTitle, for: .normal)
    }
}
