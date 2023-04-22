//
//  UIAlertController + ext.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 22.04.2023.
//

import UIKit

extension UIAlertController {
    convenience init(title: String) {
        self.init(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        self.addAction(action)
    }
}
