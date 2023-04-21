//
//  AuthorizationController.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 21.04.2023.
//

import UIKit
import SnapKit

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
        btn.setTitle("Вход через ВК", for: .normal)
//        btn.titleLabel?.font = UIFont(name: "SF Pro Text", size: 15)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        return btn
    }()
    
    //MARK: - UI Configure
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    private func configure() {
        view.backgroundColor = .white
    
        view.addSubview(mobileUpLabel)
        view.addSubview(authButton)
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
    }
}

//MARK: - Action
@objc extension AuthorizationController {
    func auth() {
        AuthService.shared.wakeUpSession()
    }
}
