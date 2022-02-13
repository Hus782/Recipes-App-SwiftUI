//
//  RecipeDetails.swift
//  SwiftUITest1
//
//  Created by Hyusein on 15.01.22.
//

import SwiftUI

struct RecipeDetails: View {
    var recipe: Recipe
    @StateObject private var viewModel = RecipeDetailsViewModel()
    @State var showWarning: Bool = false
    
    private func deleteRecipe() {
        showWarning = false
        viewModel.deleteRecipe(recipeID: recipe.id)
    }
    
    private func delete() {
        showWarning = true
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                CachedImageView(urlString: recipe.imageURL).background(Color.red)
                
                Text(recipe.name)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Image("stars")
                    .resizable()
                    .frame(width: 150.0, height: 30.0)
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                SegmentedControllView(recipe: recipe)
                
                    .navigationTitle("Details")
                    .navigationBarItems(trailing:
                                            Button {
                        delete()
                    }label: {
                        Text("Delete")
                    }
                    )
                    .navigationBarItems(trailing:
                                            NavigationLink(destination: EditRecipeView(params: RecipeParameters(name: recipe.name, imageURL: recipe.imageURL, ingredients: recipe.ingredients, steps: recipe.steps), recipeID: recipe.id), label: {
                        Text("Edit")
                    }))
                
                    .alert("Are you sure?", isPresented: $showWarning) {
                        Button("Delete", role: .destructive, action: deleteRecipe)
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Are you sure?")
                    }
            }
        }
    }
}
