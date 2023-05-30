//
//  DataModel.swift
//  Snoozee
//
//  Created by xnoag on 2023/05/30.
//

import Foundation

struct DataModel {
    var hour: Int
    var minute: Int
    var selectedWeekdays: [Weekday]
    var reminder: Int
    var soundName: String
    var isToggleActive: Bool
}

extension DataModel {
    static let sampleData: [DataModel] =
    [
        DataModel(hour: 07, minute: 00, selectedWeekdays: [.sat, .sun], reminder: 5, soundName: "개 짖는 소리", isToggleActive: true),
        DataModel(hour: 08, minute: 20, selectedWeekdays: [.mon, .tue, .wed, .thu, .fri, .sat, .sun], reminder: 3, soundName: "전파 탐지기", isToggleActive: false),
        DataModel(hour: 09, minute: 30, selectedWeekdays: [.mon, .wed, .fri], reminder: 3, soundName: "공상음", isToggleActive: true),
        DataModel(hour: 17, minute: 45, selectedWeekdays: [], reminder: 1, soundName: "없음", isToggleActive: false),
        DataModel(hour: 21, minute: 30, selectedWeekdays: [.mon, .tue, .wed, .thu, .fri], reminder: 3, soundName: "공상음", isToggleActive: false),
    ]
}
