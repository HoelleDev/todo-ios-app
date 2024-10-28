//
//  NotizenApp.swift
//  Notizen
//
//  Created by Hoeltgebaum, Daniel (SE-A/32) on 30.09.24.
//

import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ToDo.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ToDoListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
