//
//  vigaApp.swift
//  viga
//
//  Created by Isabel Rojo on 23/11/22.
//

import SwiftUI

@main
struct vigaApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager() )

        }
    }
}
