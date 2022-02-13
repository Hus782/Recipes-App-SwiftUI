//
//  RecipesListViewModel.swift
//  SwiftUITest1
//
//  Created by Hyusein on 15.01.22.
//

import SwiftUI

class RecipesListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    private let client: HTTPClientProtocol

    
    init(client: HTTPClientProtocol = HTTPClient()) {
        self.client = client
        getRecipesFromApi()
            
    }
    
    func loadRecipes() {
//        client.login(parameters: AuthenticationParameters(email: "", password: ""), completion: { result in
//            switch result {
//            case .success :
//                DispatchQueue.main.async {
//                    self.getRecipesFromApi()
////                      completion(.success(newRecipes))
//                }
//            case .failure (let error):
//                DispatchQueue.main.async {
//                    print(error)
////                      completion(.failure(error))
//                }
//            }
//        })
        
        
      }
    
    func getRecipesFromApi() {
        client.getAllRecipes(completion: { result in
            switch result {
            case .success (let newRecipes):
                DispatchQueue.main.async {
                    self.recipes = newRecipes
//                      completion(.success(newRecipes))
                }
            case .failure (let error):
                DispatchQueue.main.async {
                    self.recipes = []
                    print(error)
//                      completion(.failure(error))
                }
            }
        })
    }
}
