//
//  SwiftRecipesModels.swift
//  SwiftRecipes
//
//  Created by Eric Heidel on 7/18/24.
//

import Foundation

struct MealsResponse: Codable {
    let meals: [Meal]
}

struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    // always conform to Identifiable protocol
    var id: String { idMeal }
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strInstructions: String
    let strMealThumb: String
    let ingredients: [String]
    let measurements: [String]

    // define coding keys
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strCategory, strInstructions, strMealThumb
        case strIngredient1,
             strIngredient2,
             strIngredient3,
             strIngredient4,
             strIngredient5
        case strIngredient6,
             strIngredient7,
             strIngredient8,
             strIngredient9,
             strIngredient10
        case strIngredient11,
             strIngredient12,
             strIngredient13,
             strIngredient14,
             strIngredient15
        case strIngredient16,
             strIngredient17,
             strIngredient18,
             strIngredient19,
             strIngredient20
        case strMeasure1,
             strMeasure2,
             strMeasure3,
             strMeasure4,
             strMeasure5
        case strMeasure6,
             strMeasure7,
             strMeasure8,
             strMeasure9,
             strMeasure10
        case strMeasure11,
             strMeasure12,
             strMeasure13,
             strMeasure14,
             strMeasure15
        case strMeasure16,
             strMeasure17,
             strMeasure18,
             strMeasure19,
             strMeasure20
    }

    // map custom keys to originals
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)

        // create/map custom nested arrays
        ingredients = try (1 ... 20).compactMap { index in
            let key = CodingKeys(rawValue: "strIngredient\(index)")!
            // if ingredient exist, return it
            if let ingredient = try container.decodeIfPresent(String.self, forKey: key), !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return ingredient
            }
            // if ingredient is empty, we have reached the end, return nil
            return nil
        }

        measurements = try (1 ... 20).compactMap { index in
            let key = CodingKeys(rawValue: "strMeasure\(index)")!
            // if measurement exist, return it
            if let measurement = try container.decodeIfPresent(String.self, forKey: key), !measurement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return measurement
            }
            // if measurement is empty, we have reached the end, return nil
            return nil
        }
    }

    var ingredientsWithMeasurements: [String] {
        return zip(measurements, ingredients).map { "\($0) \($1)" }
    }
}
