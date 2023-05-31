//
//  CardView.swift
//  Snoozee
//
//  Created by SY AN on 2023/05/31.
//

import SwiftUI

struct CardView: View {
    
    @State var data: DataModel
    @State var isOn : Bool = true
    
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 24)
            .aspectRatio(0.73, contentMode: .fit)
            .onAppear {
                isOn = data.isToggleActive
            }
            .foregroundColor(data.isToggleActive ? Color(.systemGreen) : Color(.systemGray4))
            .opacity(data.isToggleActive ? 0.3 : 1)
            .overlay(
                
                VStack {
                    Toggle(isOn: $isOn) {
                    }
                    .onChange(of: isOn) { newValue in
                                    if newValue {
                                        data.isToggleActive = true
                                    } else {
                                        data.isToggleActive = false
                                    }
                                }
                    .padding(.bottom)

                    
                    HStack {
                        Text("\(String(format: "%02d", data.hour)):\(String(format: "%02d", data.minute))")
                            .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.47058824, weight: .light))
                            .fixedSize()
                        Spacer()
                        
                    }
                    
                    Group {
                        HStack {
                            Text("요일: \(data.returnWeekdays)")
                                .fixedSize()
                            Spacer()
                        }
                        
                        HStack {
                            Text("다시 알림: ")
                                .fixedSize()
                            Spacer()
                        }
                        
                        HStack {
                            Text("사운드: ")
                                .fixedSize()
                            Spacer()
                        }
                    }
                    
                    .font(.caption2)
                    Spacer()
                    
                }
                    .padding()
                    .foregroundColor(data.isToggleActive ? .white : Color(red:0.459, green: 0.459, blue: 0.459))
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(data: DataModel.sampleData[1])
            .previewLayout(.fixed(width: 169, height: 230))
    }
}


