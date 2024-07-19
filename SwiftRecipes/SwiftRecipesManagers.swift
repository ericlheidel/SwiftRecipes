//
//  SwiftRecipesManagers.swift
//  SwiftRecipes
//
//  Created by Eric Heidel on 7/18/24.
//

import Foundation

class SwiftRecipesManager {
    static let shared = SwiftRecipesManager()
    private let apiUrl = "https://themealdb.com/api/json/v1/1"

    private init() {}

    func getMealsByCategory(category: String) async throws -> [Meal] {
        // url begins as string
        let urlAsString = "\(apiUrl)/filter.php?c=\(category)"
        // url needs conversion to object
        guard let urlAsObject = URL(string: urlAsString) else {
            throw SwiftRecipesErrors.invalidURL
        }

        // GET request
        let (data, response) = try await URLSession.shared.data(from: urlAsObject)

        // confirm GET responds 200
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw SwiftRecipesErrors.invalidResponse }

        // decode the response to JSON
        do {
            let response = try JSONDecoder().decode(MealsResponse.self, from: data)
            return response.meals.sorted { $0.strMeal < $1.strMeal }
        } catch {
            throw SwiftRecipesErrors.invalidData
        }
    }

    func getMealById(id: String) async throws -> MealDetail {
        let urlAsString = "\(apiUrl)/lookup.php?i=\(id)"
        guard let urlAsObject = URL(string: urlAsString) else {
            throw SwiftRecipesErrors.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: urlAsObject)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw SwiftRecipesErrors.invalidResponse }

        do {
            let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
            guard let mealDetail = response.meals.first else { throw SwiftRecipesErrors.invalidNotFound }
            print("Received data: \(String(data: data, encoding: .utf8) ?? "No data")")
            return mealDetail
        } catch {
            throw SwiftRecipesErrors.invalidNotFound
        }
    }
}
