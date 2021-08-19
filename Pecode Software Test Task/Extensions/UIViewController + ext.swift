//
//  UIViewController + ext.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/19/21.
//

import UIKit

extension UIViewController {
    
    func presentSPAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = PSAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
