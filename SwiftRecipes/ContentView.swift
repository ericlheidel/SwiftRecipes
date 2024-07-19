//
//  ContentView.swift
//  SwiftRecipes
//
//  Created by Eric Heidel on 7/18/24.
//

import SwiftUI
import CoreData
import Foundation

struct ContentView: View {
    var body: some View {
        MealListView()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
