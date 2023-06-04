//
//  MainView.swift
//  Snoozee
//
//  Created by xnoag on 2023/06/02.
//

import SwiftUI

struct MainView: View {
    @State var dataModels: [DataModel]
    @State var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    @State var isShowingSheet: Bool = false
    @State var parameterData: DataModel = DataModel.sampleData[0]
    @State var parameterIsEditing: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack {
                    Divider()
                        .padding(.vertical)
                    LazyVGrid(columns: gridColumns) {
                        ForEach(dataModels.indices) { index in
                            if index == 0 {
                                Button(action: {
                                    isShowingSheet = true
                                    parameterData = DataModel.sampleData[0]
                                    parameterIsEditing = false
                                }) {
                                    RoundedRectangle(cornerRadius: 24)
                                        .aspectRatio(0.73, contentMode: .fit)
                                        .foregroundColor(Color(.systemGray4))
                                        .overlay (
                                            Image(systemName: "plus")
                                                .font(.largeTitle)
                                                .foregroundColor(Color(.systemOrange))
                                        )}} else {
                                            
                                            Button(action: {
                                                isShowingSheet = true
                                                parameterData = dataModels[index]
                                                parameterIsEditing = true
                                                
                                            }){
                                                CardView(dataModel: dataModels[index])
                                            }
                                        }
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("스누즈")
                .sheet(isPresented: $isShowingSheet) {
                    NavigationView{
                        SettingView(dataModel: parameterData, isEditing: parameterIsEditing)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction){
                                    Button("취소"){
                                        isShowingSheet = false
                                    }
                                    .foregroundColor(Color(.systemOrange))
                                }
                                ToolbarItem(placement: .principal) {
                                    Text(parameterIsEditing ? "알람 편집" : "알람 추가")
                                        .fontWeight(.bold)
                                }
                                
                                
                                ToolbarItem(placement: .confirmationAction){
                                    Button("저장"){
                                        isShowingSheet = false
                                    }
                                    .foregroundColor(Color(.systemOrange))
                                }
                            }
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(dataModels: DataModel.sampleData)
    }
}
