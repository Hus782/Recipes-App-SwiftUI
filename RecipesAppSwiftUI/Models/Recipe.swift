//
//  Recipe.swift
//  SwiftUITest1
//
//  Created by Hyusein on 14.01.22.
//

import Foundation

struct Recipe: Identifiable, Decodable, Encodable{
    let id: String
    var name: String
    let imageURL: String
    var ingredients: String
    var steps: String
}
