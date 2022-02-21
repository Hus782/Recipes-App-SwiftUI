//
//  LoginView.swift
//  SwiftUITest1
//
//  Created by Hyusein on 22.01.22.
//

import SwiftUI

struct ShakeEffect : GeometryEffect {
    var travelDistance: Float = 6
    var numOfShakes: Float = 6
    var animatableData: Float
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: CGFloat(travelDistance * sin(animatableData * .pi * numOfShakes)), y: 0))
    }
}

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
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
            HStack {
                Image("user").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
            SecureField("Password", text: $viewModel.password)
                    
                .cornerRadius(5.0)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundColor(viewModel.attempts == 0 ? .clear : .red)).modifier(ShakeEffect(animatableData: Float(viewModel.attempts)))
            
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
