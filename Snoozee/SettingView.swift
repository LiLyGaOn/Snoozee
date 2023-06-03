//
//  SettingView.swift
//  Snoozee
//
//  Created by SY AN on 2023/06/03.
//

import SwiftUI

struct SettingView: View {
    @State private var selectedTime = Date()
    var dataModel: DataModel
    let isEditing: Bool
    
    var body: some View {
        VStack {
            DatePicker("Select a time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .fixedSize()
                
            List{
                HStack{
                    Text("요일")
                    Spacer()
                    Text("\(dataModel.returnWeekdays)")
                        .foregroundColor(Color(red:0.459, green: 0.459, blue: 0.459))
                }
                
                HStack{
                    Text("다시 알림")
                    Spacer()
                    Text("\(dataModel.reminder)분 뒤")
                        .foregroundColor(Color(red:0.459, green: 0.459, blue: 0.459))
                }
                
                HStack{
                    Text("사운드")
                    Spacer()
                    Text("\(dataModel.soundName)")
                        .foregroundColor(Color(red:0.459, green: 0.459, blue: 0.459))
                }
                
                if isEditing{
                    Section{
                        Button(action: {}) {
                            HStack{
                                Spacer()
                                Text("알람 삭제")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(dataModel: DataModel.sampleData[0], isEditing: true)
    }
}



