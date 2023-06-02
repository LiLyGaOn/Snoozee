//
//  DataModel.swift
//  Snoozee
//
//  Created by xnoag on 2023/05/30.
//

import Foundation
import SwiftUI

struct DataModel : Identifiable{
    
    var id: UUID
    var hour: Int
    var minute: Int
    var selectedWeekdays: [Weekday]
    var returnWeekdays: String {
        returnWeekdays(selectedWeekdays: self.selectedWeekdays)
    }
    
    var reminder: Int
    var soundName: String
    var isToggleActive: Bool
    
    
    init(id: UUID = UUID(), hour: Int, minute: Int, selectedWeekdays: [Weekday], reminder: Int, soundName: String, isToggleActive: Bool) {
        self.id = id
        self.hour = hour
        self.minute = minute
        self.selectedWeekdays = selectedWeekdays
        self.reminder = reminder
        self.soundName = soundName
        self.isToggleActive = isToggleActive
    }
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

extension DataModel {
 
    func returnWeekdays(selectedWeekdays: [Weekday]) -> String {
        if selectedWeekdays.count == 0 {
            return ("없음")
        } else if selectedWeekdays.count == 7 {
            return ("매일")
        } else if selectedWeekdays.contains(Weekday.sat) && selectedWeekdays.contains(Weekday.sun) && selectedWeekdays.count == 2{
            return ("주말")
        }else if !(selectedWeekdays.contains(Weekday.sat) && selectedWeekdays.contains(Weekday.sun)) && (selectedWeekdays.count == 5){
            return ("주중")
        }else {
            var temp = ""
            
            for i in 0...selectedWeekdays.count-1 {
                if i == selectedWeekdays.count-1 {
                    temp = temp + selectedWeekdays[i].rawValue
                } else {
                    temp = temp + selectedWeekdays[i].rawValue + ", "
                }
            }

            return (temp)
        }
    }
    
    
}
