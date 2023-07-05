//
//  DataStore.swift
//  Snoozee
//
//  Created by SY AN on 2023/07/06.
//

import SwiftUI

class DataStore: ObservableObject {
    
    @Published var alarms : [DataModel] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("alarms.data")
    }

    func load() async throws {
            let task = Task<[DataModel], Error> {
                let fileURL = try Self.fileURL()
                guard let data = try? Data(contentsOf: fileURL) else {
                    return []
                }
                let dataModels = try JSONDecoder().decode([DataModel].self, from: data)
                return dataModels
            }
            let alarms = try await task.value
            self.alarms = alarms
        }
    
    func save(scrums: [DataModel]) async throws {
            let task = Task {
                let data = try JSONEncoder().encode(scrums)
                let outfile = try Self.fileURL()
                try data.write(to: outfile)
            }
            _ = try await task.value
        }
}
