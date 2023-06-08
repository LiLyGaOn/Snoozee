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
    @State var isLongPressed: Bool = false
    @State var isSelected: [Bool]
      
      init(dataModels: [DataModel]) {
          self._dataModels = State(initialValue: dataModels)
          self._isSelected = State(initialValue: Array(repeating: false, count: dataModels.count))
      }
    
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
                                    CardView(dataModel: dataModels[index])
                                    .overlay(
                                        Button(action: {
                                            isLongPressed = false
                                            // 삭제 기능
                                        }){
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                        }
                                            .padding()
                                            .opacity(isLongPressed ? 1 : 0)
                                        , alignment: .topLeading
                                    
                                    )
                                    .opacity(isSelected[index] ? 0.5 : 1)
                                    .gesture(
                                        LongPressGesture()
                                            .onChanged{ _ in
                                                isSelected[index] = true
                                            }
                                            .onEnded { _ in
                                                isSelected[index] = false
                                                isLongPressed = true
                                            }
                                            .simultaneously(with: TapGesture().onEnded { _ in
                                                isSelected[index] = false
                                                selectedDataModel = dataModels[index]
                                            })
                                    )
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("스누즈")
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") {
                       isLongPressed = false
                    }
                    .foregroundColor(Color(.systemOrange))
                    .opacity(isLongPressed ? 1 : 0)
                }
            }
        }
        .onAppear{
            isLongPressed = false
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
