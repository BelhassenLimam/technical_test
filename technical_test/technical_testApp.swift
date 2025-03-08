//
//  technical_testApp.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import SwiftUI

@main
struct technical_testApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
