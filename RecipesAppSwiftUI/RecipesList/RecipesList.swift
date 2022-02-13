//
//  RecipesList.swift
//  SwiftUITest1
//
//  Created by Hyusein on 15.01.22.
//

import SwiftUI

struct RecipesList: View {
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var recipes: [Recipe]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetails(recipe: recipe), label: {
                        ListCell(recipe: recipe)
                    })
                }
            }
        }
    }
}

struct ListCell: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            CachedImageView(urlString: recipe.imageURL).frame(maxWidth: 130.0, maxHeight: 130.0)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Image("stars")
                    .resizable()
                    .frame(maxWidth: 130.0, maxHeight: 30.0)
                Text("goodeats.com")
                    .font(.body)
                    .lineLimit(2)
                
            }
            Spacer()
        }
        
    }
}


    
