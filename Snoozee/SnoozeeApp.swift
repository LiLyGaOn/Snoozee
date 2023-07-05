//
//  SnoozeeApp.swift
//  Snoozee
//
//  Created by xnoag on 2023/05/30.
//

import SwiftUI

@main
struct SnoozeeApp: App {
    @StateObject private var store = DataStore()
    
    var body: some Scene {
        WindowGroup {
            MainView(dataModels: $store.alarms){
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
