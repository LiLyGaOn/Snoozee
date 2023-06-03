//
//  ReminderView.swift
//  Snoozee
//
//  Created by SY AN on 2023/06/03.
//

import SwiftUI

struct ReminderView: View {
    @State private var selectedRow: Int = 0
    
    let reminderText = ["1분 뒤", "2분 뒤", "3분 뒤", "4분 뒤", "5분 뒤", "10분 뒤", "안 함"]
    
    var body: some View {
        VStack{
            List {
                ForEach(reminderText.indices, id: \.self) { index in
                    Button(action: {
                        selectedRow = index
                    }) {
                        HStack {
                            Text(reminderText[index])
                                .foregroundColor(.white)
                            Spacer()
                            if selectedRow == index {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.yellow)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
            }
        }
    }
}
    

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
