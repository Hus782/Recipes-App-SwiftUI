//
//  Constants.swift
//  SwiftUITest1
//
//  Created by Hyusein on 15.01.22.
//

import Foundation

struct Constants {
//    static let noRatingImage = UIImage(named: "0.png")!
//    static let placeHolderImage = UIImage(named: "placeholder")!
//    static let listModeImage = UIImage(systemName: "list.dash")!
//    static let gridModeImage = UIImage(systemName: "square.grid.2x2.fill")!
        
    // Strings
    static let authToken = "authToken"
    static let userEmail = "userEmail"

    // URLs
    static let singinURL = URL(string: "https://recipes-api-f0710.web.app/api/v1/auth/signin")!
    static let singupURL = URL(string: "https://recipes-api-f0710.web.app/api/v1/auth/signup")!
    static let getAllRecipesURL = URL(string: "https://recipes-api-f0710.web.app/api/v1/recipes")!
    static let editRecipeString = "https://recipes-api-f0710.web.app/api/v1/recipes"
}
