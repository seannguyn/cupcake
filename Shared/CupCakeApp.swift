//
//  CupCakeApp.swift
//  Shared
//
//  Created by Tuan Son Nguyen on 4/3/21.
//

import SwiftUI

@main
struct CupCakeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
