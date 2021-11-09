//
//  Struct.swift
//  Ricettario
//
//  Created by Gennaro Cotarella on 04/01/2021.
//  Copyright © 2021 Gennaro Cotarella. All rights reserved.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let name: String
    let ingredients: [Ingredients]
    let steps: [Steps]
    let servings: Int
    let image: String
}

struct Ingredients: Codable {
    let quantity: Float
    let measure: String
    let ingredient: String
}

struct Steps: Codable {
    let id: Int
    let shortDescription: String
    let description: String
    let videoURL: String
    let thumbnailURL: String
}

struct Recipe2: Codable {
    var offset: Int
    var number: Int
    var results: [Details]
    var totalResults: Int
}

struct Details: Codable {
    var id: Int
    var calories: Int
    var carbs: String
    var fat: String
    var image: String
    var imageType: String
    var protein: String
    var title: String
}

struct Prova: Codable {
    var results: [Dettaglio]
    var offset: Int
    var number: Int
    var totalResults: Int
}

struct Dettaglio: Codable {
    var id: Int
    var title: String
    var image: String
    var imageType: String
}
