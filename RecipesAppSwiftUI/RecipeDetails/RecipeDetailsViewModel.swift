//
//  RecipeDetailsViewModel.swift
//  SwiftUITest1
//
//  Created by Hyusein on 20.01.22.
//

import SwiftUI

class RecipeDetailsViewModel: ObservableObject {
    private let client: HTTPClientProtocol
    @Published var showingDeleteAlert = false
    @Published var goBack = false
    
    init(client: HTTPClientProtocol = HTTPClient()) {
        self.client = client
        
    }
    
    func deleteRecipe(recipeID: String) {
        
        client.deleteRecipe(recipeID: recipeID, completion: { [weak self] result in
            switch result {
            case .success:
                self?.goBack = true
                
            case .failure (let error):
                print(error)
                //                    self?.showingDeleteAlert = true
                
            }
        })
    }
}
