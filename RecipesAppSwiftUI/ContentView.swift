//
//  ContentView.swift
//  SwiftUITest1
//
//  Created by Hyusein on 10.01.22.
//

import SwiftUI

struct RecipesListView: View {
    let isGrid: Bool
    let recipes: [Recipe]
    
    var body: some View {
        if isGrid {
            RecipesGrid(recipes: recipes)
        } else {
            RecipesList(recipes: recipes)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var tokenManager: AccessTokenManager
    @StateObject private var viewModel = RecipesListViewModel()
    @State private var isGrid = true
    
    var body: some View {
        
        NavigationView {
            RecipesListView(isGrid: isGrid, recipes: viewModel.recipes)
                .navigationTitle("Recipes")
                .navigationBarItems(trailing:
                                        Button {
                    isGrid.toggle()
                }label: {
                    Image(systemName: "list.dash")
                }
                )
            
            
                .navigationBarItems(leading:
                                        NavigationLink(destination: AddRecipeView(), label: {
                    Text("Add")
                })
                )
                .navigationBarItems(leading:
                                        NavigationLink(destination: LoginView(), label: {
                    Text("Login")
                })
                )
                .navigationBarItems(trailing:
                                        Button(action: {
                    do{
                        try tokenManager.deleteToken()
                    } catch {
                        
                    }
                    
                }) {
                    Text("Logout")
                    
                }
                )
            
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
        
    }
}
