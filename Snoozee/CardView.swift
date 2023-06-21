//
//  CardView.swift
//  Snoozee
//
//  Created by SY AN on 2023/05/31.
//

import SwiftUI

struct CardView: View {
    @State var dataModel: DataModel
    @Binding var isLongPressed: Bool
    
    var body: some View {
        let isToggleActive = Binding<Bool>(
            get: { dataModel.isToggleActive },
            set: { newValue in
                dataModel.isToggleActive = newValue
            }
        )
        
        let isToggleActive2 = Binding<Bool>(
            get: { dataModel.isToggleActive2 },
            set: { newValue in
                dataModel.isToggleActive2 = newValue
            }
        )
        
        RoundedRectangle(cornerRadius: 24)
            .aspectRatio(0.73, contentMode: .fit)
            .foregroundColor(dataModel.isToggleActive ? Color(.systemGreen) : Color(.systemGray4))
            .opacity(dataModel.isToggleActive ? 0.3 : 1)
            .overlay(
                VStack {
                    if !isLongPressed {
                        Toggle(isOn: isToggleActive) {
                        }.onTapGesture {
                            isToggleActive.wrappedValue.toggle()
                        }.tint(.green)
                            .padding(.bottom)
                    } else {
                        Toggle(isOn: isToggleActive2) {
                        }
                        .disabled(true)
                        .padding(.bottom)
                        .opacity(0)
                    }
                    HStack {
                        Text("\(String(format: "%02d", dataModel.hour)):\(String(format: "%02d", dataModel.minute))")
                            .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.7, weight: .light))
                            .fixedSize()
                            .padding(.bottom)
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("요일: \(dataModel.returnWeekdays)")
                                .fixedSize()
                            Text("다시 알림: \(dataModel.reminder)분 뒤")
                                .fixedSize()
                            Text("사운드: \(dataModel.soundName)")
                                .fixedSize()
                        }
                        Spacer()
                    }
                    .font(.system(size: UIFont.textStyleSize(.caption2) * 1.2, weight: .light))
                    
                    Spacer()
                }
                    .padding()
                    .foregroundColor(dataModel.isToggleActive ? .white : Color(red:0.459, green: 0.459, blue: 0.459))
            )
            .contentShape(Rectangle()) //
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(dataModel: DataModel.sampleData[1], isLongPressed: .constant(false))
    }
}


