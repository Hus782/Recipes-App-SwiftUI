//
//  EditRecipeView.swift
//  SwiftUITest1
//
//  Created by Hyusein on 20.01.22.
//

import SwiftUI

struct EditRecipeView: View {
    
    @State var params: RecipeParameters
    var recipeID: String
    
    @StateObject private var viewModel = EditRecipeViewModel()
    @Environment(\.dismiss) var dismiss
    
    private func editRecipe() {
        viewModel.editRecipe(params: params, id: recipeID)
    }

//    init(recipeID: String, params: RecipeParameters) {
//        print("called init here")
//        self.recipeID = recipeID
//        self.params = params
//        //viewModel.setParams(params: params)
//    //    self.viewModel = EditRecipeViewModel()
//    }
    
    var body: some View {
        RecipeFormView(params: $params)
            .navigationTitle("Edit Recipe")
        
            .navigationBarItems(trailing:
                                    NavBarLoadingButton(isLoading: viewModel.isLoading, action: {
                editRecipe()
            }, title: "Save")
            )
        
            .alert("Something went wrong", isPresented: $viewModel.showingErrorAlert) {
                Button("Retry", role: .destructive, action: editRecipe)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("You can try again")
            }
        
            .onChange(of: viewModel.goBack) { goBack in
                if goBack {
                    dismiss()
                }
            }
    }
}
