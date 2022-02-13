//
//  SegmentedControllView.swift
//  SwiftUITest1
//
//  Created by Hyusein on 24.01.22.
//

import SwiftUI

struct SegmentedControllView: View {
    var recipe: Recipe
    @State private var mode = 0
    
    var body: some View {
        Picker("Mode", selection: $mode) {
            Text("Steps").tag(0)
            Text("Ingredients").tag(1)
            
        }
        .pickerStyle(.segmented)
        if mode == 0 {
            Text(recipe.steps)
                .font(.body).padding(.trailing).padding(.leading)
        } else {
            Text(recipe.ingredients)
                .font(.body).padding(.trailing).padding(.leading)
        }
    }
}
