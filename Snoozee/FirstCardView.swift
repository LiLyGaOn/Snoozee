//
//  FirstCardView.swift
//  Snoozee
//
//  Created by SY AN on 2023/06/06.
//

import SwiftUI

struct FirstCardView: View {
    @State var dataModel: DataModel
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .aspectRatio(0.73, contentMode: .fit)
            .foregroundColor(Color(.systemGray4))
            .overlay (
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(Color(.systemOrange))
            )
            .onTapGesture {
                isShowingSheet = true
            }
        
            .sheet(isPresented: $isShowingSheet) {
                NavigationView {
                    SettingView(dataModel: .constant(dataModel), isEditing: false)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("취소") {
                                    isShowingSheet = false
                                }
                                .foregroundColor(Color(.systemOrange))
                            }
                            ToolbarItem(placement: .principal) {
                                Text("알람 추가")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("저장") {
                                    isShowingSheet = false
                                }
                                .foregroundColor(Color(.systemOrange))
                            }
                        }
                }
            }
    }
}


struct FirstCardView_Previews: PreviewProvider {
    static var previews: some View {
        FirstCardView(dataModel: DataModel.sampleData[1])
    }
}
