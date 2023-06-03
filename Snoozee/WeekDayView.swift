//
//  WeekDayView.swift
//  Snoozee
//
//  Created by xnoag on 2023/06/03.
//

import SwiftUI

struct ReminderView: View {
    @State var selectedWeekdays: [Weekday] = []
    var body: some View {
        List {
            ForEach(Weekday.allCases) { weekday in
                HStack {
                    Button(action: {
                        toggleWeekday(weekday)
                        print(selectedWeekdays)
                    }) {
                        Text("\(weekday.rawValue)요일마다")
                            .foregroundColor(Color(.white))
                    }
                    Spacer()
                    
                    if selectedWeekdays.contains(weekday) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.yellow)
                            .fontWeight(.bold)
                    } else {
                        Image(systemName: "")
                    }
                }
            }
        }
    }
    
    func toggleWeekday(_ weekday: Weekday) {
        if selectedWeekdays.contains(weekday) {
            selectedWeekdays.removeAll(where: { $0 == weekday })
        } else {
            selectedWeekdays.append(weekday)
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}

