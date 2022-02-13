//
//  RecipesAppSwiftUIApp.swift
//  RecipesAppSwiftUI
//
//  Created by Hyusein on 9.02.22.
//

import SwiftUI

@main
struct SwiftUITest1App: App {
    @StateObject var tokenManager = AccessTokenManager()
    
    var body: some Scene {
        WindowGroup {
            if tokenManager.isAuthorized {
                ContentView().environmentObject(tokenManager)
            } else {
                LoginView().environmentObject(tokenManager)
            }
            
        }
    }
}
