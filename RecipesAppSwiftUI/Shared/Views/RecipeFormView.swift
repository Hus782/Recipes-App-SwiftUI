//
//  RecipeFormView.swift
//  SwiftUITest1
//
//  Created by Hyusein on 24.01.22.
//

import SwiftUI

struct RecipeFormView: View {
    @Binding var params: RecipeParameters
            
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextEditor(text: $params.name).fixedSize(horizontal: false, vertical: true)
            }
            Section(header: Text("Image URL")) {
                TextEditor(text: $params.imageURL).fixedSize(horizontal: false, vertical: true)
            }
            Section(header: Text("Ingredients")) {
                TextEditor(text: $params.ingredients).fixedSize(horizontal: false, vertical: true)
            }
            Section(header: Text("Preparation steps")) {
                TextEditor(text: $params.steps).fixedSize(horizontal: false, vertical: true)
            }
            
        }
    }
}
