//
//  AddRecipeView.swift
//  SwiftUITest1
//
//  Created by Hyusein on 18.01.22.
//

import SwiftUI

struct AddRecipeView: View {
    
    
    @StateObject private var viewModel = AddRecipeViewModel()
    @Environment(\.dismiss) var dismiss
    
    private func saveRecipe() {
        viewModel.addRecipe(params: viewModel.params)
    }
    
    var body: some View {
        RecipeFormView(params: $viewModel.params)
            .navigationTitle("Add Recipe")
        
            .navigationBarItems(trailing:
                                    NavBarLoadingButton(isLoading: viewModel.isLoading, action: {
                saveRecipe()
            }, title: "Save").disabled(viewModel.disabled)
            )
        
            .alert("Something went wrong", isPresented: $viewModel.showingErrorAlert) {
                Button("Delete", role: .destructive, action: saveRecipe)
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
