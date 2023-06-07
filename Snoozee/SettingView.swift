//
//  SettingView.swift
//  Snoozee
//
//  Created by SY AN on 2023/06/03.
//

import SwiftUI

struct SettingView: View {
    @State private var selectedTime = Date()
    @Binding var dataModel: DataModel
    var isEditing: Bool
    
    var body: some View {
            VStack {
                DatePicker("Select a time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .fixedSize()
                
                List{
                    NavigationLink(destination: WeekDayView()){
                        HStack{
                            Text("요일")
                            Spacer()
                            Text("\(dataModel.returnWeekdays)")
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    
                    NavigationLink(destination: ReminderView()){
                        HStack{
                            Text("다시 알림")
                            Spacer()
                            Text("\(dataModel.reminder)분 뒤")
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    
                    HStack{
                        Text("사운드")
                        Spacer()
                        Text("\(dataModel.soundName)")
                            .foregroundColor(Color(.systemGray))
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
        SettingView(dataModel: .constant(DataModel.sampleData[3]), isEditing: true)
    }
}



