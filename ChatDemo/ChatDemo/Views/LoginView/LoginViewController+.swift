//
//  LoginViewController+.swift
//  ChatDemo
//
//  Created by 진태영 on 11/2/23.
//

import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    // Textfield에서 붙여넣기, 삭제 기능
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Range(range, in: text): 갱신된 range 값과 기존 string을 가지고 객체 변환: NSRange -> Range
        guard let oldString = textField.text, let newRange = Range(range, in: oldString) else { return true }
        
        // range 값과 inputString을 가지고 replacingCharacters(in:with:)을 이용하여 String 업데이트
        let inputString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let newString = oldString.replacingCharacters(in: newRange, with: inputString)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        loginButton.isEnabled = !newString.isEmpty
        
        return true
    }
}

