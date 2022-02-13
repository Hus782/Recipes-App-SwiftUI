//
//  LoginView.swift
//  SwiftUITest1
//
//  Created by Hyusein on 22.01.22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var tokenManager: AccessTokenManager
    @StateObject private var viewModel = LoginViewModel()
    
    private func login() {
        viewModel.login()
    }
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            Image("user")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .padding(.bottom, 75)
            
            TextField("Username", text: $viewModel.email)
                .padding()
            //                       .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
            //                       .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
//            Text("Emails or password is incorrect")
//                .font(.callout)
//                .foregroundColor(Color.red)
            
            AuthLoadingButton(isLoading: viewModel.isLoading, action: {
                login()
            }, title: "Login")
        }.padding()
        
            .onChange(of: viewModel.token) { token in
                tokenManager.saveToken(token: token)
            }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        
        LoginView()
        
    }
}
