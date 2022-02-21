//
//  LoginViewModel.swift
//  SwiftUITest1
//
//  Created by Hyusein on 22.01.22.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    private var tokenManager: AccessTokenManager
    private var fieldValidator: FieldValidator
    @Published var isLoading = false
    @Published var showingErrorAlert = false
    @Published var token = ""
    @Published var email: String = "hyusein.hyusein@paysafe.com"
    @Published var password: String = "Test1234"
    @Published var attempts: Int = 0
    
    private let client: AuthenticationClient
    
    init(client: AuthenticationClient = AuthenticationClient(), tokenManager: AccessTokenManager = AccessTokenManager(), fieldValidator: FieldValidator = FieldValidator()) {
        self.client = client
        self.tokenManager = tokenManager
        self.fieldValidator = fieldValidator
    }
    
    func login() {
        let (isValid, errorMessage) = fieldValidator.validateEmailField(email)
        if !isValid {
            print(errorMessage)
            return
        }
        let params = AuthenticationParameters(email: email, password: password)
        isLoading = true
        client.login(parameters: params, completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .failure(let error):
                withAnimation {
                    self?.attempts+=1
                }
                print(error)
            case .success(let token):
                self?.token = token
            }
        })
    }
}
