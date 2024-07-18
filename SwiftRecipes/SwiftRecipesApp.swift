//
//  SwiftRecipesApp.swift
//  SwiftRecipes
//
//  Created by Eric Heidel on 7/18/24.
//

import SwiftUI

@main
struct SwiftRecipesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
