//
//  Validator.swift
//  SwiftUITest1
//
//  Created by Hyusein on 6.02.22.
//

import Foundation

class FieldValidator {
    
    func validateEmailField(_ text: String) -> (isValid: Bool, errorMessage: String?) {
        let isEmpty = text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isValidEmail = isValidEmail(text)
        
        if isEmpty {
            return (isValid: false, errorMessage: "Email field should not be empty.")
        }
        if !isValidEmail {
            return (isValid: false, errorMessage: "Invalid email.")
        }
        return (isValid: true, errorMessage: nil)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
