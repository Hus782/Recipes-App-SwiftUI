//
//  Codables.swift
//  SwiftUITest1
//
//  Created by Hyusein on 9.02.22.
//

import Foundation

enum NetworkError: Error {
    case responseError
    case authenticationError
    case loginError
    case decodingError
    case registrationError
}

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

struct AuthenticationResponse: Codable {
    let authToken: String
}

struct RegistrationResponse: Codable {
    let id: String
}

struct AddRecipeResponse: Codable {
    let id: String
}

struct DeleteRecipeResponse: Codable {
 
}

struct RecipeParameters: Encodable {
    var name: String
    var imageURL: String
    var ingredients: String
    var steps: String
    
    init() {
        name = ""
        imageURL = ""
        ingredients = ""
        steps = ""
    }
    
    init(name: String, imageURL: String, ingredients: String, steps: String) {
        self.name = name
        self.imageURL = imageURL
        self.ingredients = ingredients
        self.steps = steps
    }
}

struct EditRecipeParameters: Encodable {
    var id: String
    var name: String
    var imageURL: String
    var ingredients: String
    var steps: String
    
    
    init(id: String, params: RecipeParameters) {
        self.id = id
        self.name = params.name
        self.imageURL = params.imageURL
        self.ingredients = params.ingredients
        self.steps = params.steps
    }
}
struct AuthenticationParameters: Encodable {
    let email: String
    let password: String
}
