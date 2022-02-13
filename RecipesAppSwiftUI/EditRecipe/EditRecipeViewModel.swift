//
//  EditRecipeViewModel.swift
//  SwiftUITest1
//
//  Created by Hyusein on 22.01.22.
//

import SwiftUI

class EditRecipeViewModel: ObservableObject {
    private let client: HTTPClientProtocol
    @Published  var isLoading = false
    @Published  var showingErrorAlert = false
    @Published  var goBack = false
    @Published var disabled = true
    
    @Published  var params: RecipeParameters = RecipeParameters() {
        didSet {
            disabled = params.steps.isEmpty || params.ingredients.isEmpty || params.imageURL.isEmpty || params.name.isEmpty
        }
    }
    
    func setParams(params: RecipeParameters) {
        self.params = params
    }
    init(client: HTTPClientProtocol = HTTPClient()) {
        self.client = client
    }
    
    func editRecipe(params: RecipeParameters, id: String) {
        isLoading = true
        showingErrorAlert = false
        client.editRecipe(parameters: params, recipeID: id, completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success:
                self?.goBack = true
            case .failure:
                self?.showingErrorAlert = true
            }
        })
    }
}
