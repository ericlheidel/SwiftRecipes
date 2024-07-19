//
//  SwiftRecipesMealListView.swift
//  SwiftRecipes
//
//  Created by Eric Heidel on 7/18/24.
//

import Foundation
import SwiftUI

struct MealListView: View {
    @State private var meals: [Meal] = []
    @State private var selectedMeal: Meal?

    var body: some View {
        NavigationView {
            List(meals) { meal in
                NavigationLink(destination: MealDetailView(meal: meal)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 10)
                                .frame(width: 75, height: 75)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(meal.strMeal)
                    }
                }
            }
            .navigationTitle("Desserts")
        }
        .onAppear {
            Task {
                do {
                    meals = try await SwiftRecipesManager.shared.getMealsByCategory(category: "Dessert")
                } catch {
                    throw SwiftRecipesErrors.invalidResponse
                }
            }
        }
    }
}
