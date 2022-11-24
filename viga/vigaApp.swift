//
//  vigaApp.swift
//  viga
//
//  Created by Rocío del Carmen on 23/11/22.
//

import SwiftUI

@main
struct vigaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
