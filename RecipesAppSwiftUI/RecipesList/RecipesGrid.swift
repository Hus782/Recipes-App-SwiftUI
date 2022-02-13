//
//  RecipesGrid.swift
//  SwiftUITest1
//
//  Created by Hyusein on 15.01.22.
//

import SwiftUI

struct RecipesGrid: View {
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150, maximum: 150)),
        GridItem(.adaptive(minimum: 150, maximum: 150)),
        GridItem(.adaptive(minimum: 150, maximum: 150))
    ]
    
    var recipes: [Recipe]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetails(recipe: recipe), label: {
                        Cell(recipe: recipe)
                    })
                }
            }
        }
    }
}

struct Cell: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            CachedImageView(urlString: recipe.imageURL).frame(maxWidth: 150.0, maxHeight: 150.0)

            Image("stars")
                .resizable()
                .frame(maxWidth: 150.0, maxHeight: 30.0)
            Text(recipe.name)
                .font(.headline)
                .lineLimit(2)
        }
    }
}


