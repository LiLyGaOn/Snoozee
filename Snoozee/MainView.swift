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
    @State var selectedDataModel: DataModel? = nil
    
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
                                    selectedDataModel = dataModels[index]
                                }) {
                                    FirstCardView(dataModel: dataModels[index])
                                }
                            } else {
                                Button(action: {
                                    selectedDataModel = dataModels[index]
                                }) {
                                    CardView(dataModel: dataModels[index])
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("스누즈")
            }
        }
        .sheet(item: $selectedDataModel) { dataModel in
            NavigationView {
                SettingView(dataModel: .constant(dataModel), isEditing: true)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("취소") {
                               selectedDataModel = nil
                            }
                            .foregroundColor(Color(.systemOrange))
                        }
                        ToolbarItem(placement: .principal) {
                            Text("알람 편집")
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("저장") {
                                selectedDataModel = nil
                            }
                            .foregroundColor(Color(.systemOrange))
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
