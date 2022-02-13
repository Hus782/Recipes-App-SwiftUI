//
//  LoadingButton.swift
//  SwiftUITest1
//
//  Created by Hyusein on 24.01.22.
//

import SwiftUI

struct NavBarLoadingButton: View {
    
    let isLoading: Bool
    let action: () -> Void
    let title: String
    
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            Button {
                action()
            }label: {
                Text(title)
            }
        }
    }
}

struct AuthLoadingButton: View {
    
    let isLoading: Bool
    let action: () -> Void
    let title: String
    
    var body: some View {
            Button {
                action()
            }label: {
                if isLoading {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                } else {
                Text(title)
         
                }
        }    .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}


