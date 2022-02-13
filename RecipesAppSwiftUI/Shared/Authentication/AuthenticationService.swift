//
//  AuthenticationService.swift
//  SwiftUITest1
//
//  Created by Hyusein on 22.01.22.
//

import Foundation

class AuthenticationService: ObservableObject {
    @Published var isValidated = false
    
    var email: String? { get {
        return UserDefaults.standard.string(forKey: "email")
    } set {
        UserDefaults.standard.set(newValue, forKey: "email")
    }
    }
    
    var token: String? { get {
        return UserDefaults.standard.string(forKey: "token")
    } set {
        UserDefaults.standard.set(newValue, forKey: "token")
    }
    }
}
