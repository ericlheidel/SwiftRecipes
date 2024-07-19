// //
// //  SwiftRecipesMealDetailView.swift
// //  SwiftRecipes
// //
// //  Created by Eric Heidel on 7/18/24.
// //

// import Foundation
// import SwiftUI

// struct MealDetailView: View {
//     let meal: Meal
//     @State private var mealDetail: MealDetail?

//     var body: some View {
//         VStack(alignment: .leading) {
//             if let mealDetail = mealDetail {
//                 AsyncImage(url: URL(string: meal.strMealThumb)) { image in
//                     image.resizable()
//                         .scaledToFit()
//                         .frame(width: 100, height: 100)
//                         .clipShape(Circle())
//                 } placeholder: {
//                     ProgressView()
//                 }
//                 Text(mealDetail.strMeal)
//                     .font(.title)
//                     .padding()
//                 Text("Instructions:")
//                     .font(.headline)
//                     .padding(.top)

//                 Text(mealDetail.strInstructions)
//                     .padding()

//                 Text("Ingredients:")
//                     .font(.headline)
//                     .padding(.top)

//                 ForEach(mealDetail.ingredients, id: \.self) { ingredient in
//                     Text(ingredient)
//                         .padding(.bottom, 1)
//                 }
//             } else {
//                 ProgressView()
//                     .onAppear {
//                         Task {
//                             do {
//                                 mealDetail = try await SwiftRecipesManager.shared.getMealById(id: meal.idMeal)
//                             } catch {
//                                 throw SwiftRecipesErrors.invalidNotFound
//                             }
//                         }
//                     }
//             }
//         }
//         .navigationTitle(meal.strMeal)
//         .padding()
//     }
// }

import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    @State private var mealDetail: MealDetail?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let mealDetail = mealDetail {
                    HStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)
                                .padding(.horizontal)
                        } placeholder: {
                            ProgressView()
                                .frame(height: 250)
                        }
                    }
                    .frame(maxWidth: .infinity) // Center horizontally
                    VStack(alignment: .leading, spacing: 10) {
                        Text("     Instructions")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 5)

                        Text(mealDetail.strInstructions)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)

                        Text("Ingredients")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)

                        ForEach(mealDetail.ingredientsWithMeasurements, id: \.self) { ingredientsWithMeasurement in
                            Text(ingredientsWithMeasurement)
                                .padding(.horizontal)
                        }
                        Text("")
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                } else {
                    ProgressView()
                        .onAppear {
                            Task {
                                do {
                                    mealDetail = try await SwiftRecipesManager.shared.getMealById(id: meal.idMeal)
                                } catch {
                                    print("Failed to load meal details: \(error)")
                                }
                            }
                        }
                }
            }
            .navigationTitle(meal.strMeal)
            .padding(.top)
        }
    }
}
