//
//  AddRecipeViewModel.swift
//  SwiftUITest1
//
//  Created by Hyusein on 18.01.22.
//

import SwiftUI

class AddRecipeViewModel: ObservableObject {
    private let client: HTTPClientProtocol
    @Published  var params: RecipeParameters = RecipeParameters() {
        didSet {
            disabled = params.steps.isEmpty || params.ingredients.isEmpty || params.imageURL.isEmpty || params.name.isEmpty
        }
    }
    
    @Published  var isLoading = false
    @Published  var showingErrorAlert = false
    @Published  var goBack = false
    @Published var disabled = true
    
    init(client: HTTPClientProtocol = HTTPClient()) {
        self.client = client
        
    }
    
    func addRecipe(params: RecipeParameters) {
        isLoading = true
        showingErrorAlert = false
        client.addRecipe(parameters: params, completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success:
                self?.goBack = true
            case .failure (let error):
                print(error)
                self?.showingErrorAlert = true
                
            }
        })
    }
}
