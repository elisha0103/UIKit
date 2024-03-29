//
//  UIColor+.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

extension UIColor {
    /// Label color
    ///
    /// 푸른 파란색 (91, 156, 203, 1)
    static var primary = UIColor(red: 91/255, green: 156/255, blue: 203/255, alpha: 1)
    /// 연한 회색
    static var incomingMessageBackground = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}
