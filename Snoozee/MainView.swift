//
//  MainView.swift
//  Snoozee
//
//  Created by xnoag on 2023/06/02.
//

import SwiftUI
import UIKit

struct MainView: View {
    @State var dataModels: [DataModel]
    @State var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    @State var selectedDataModel: DataModel? = nil
    @State var isDeleting: Bool = false
    @State var isPlus: Bool? = nil
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    @State var cardOffset: CGSize = .zero // 추가: 카드 위치를 조정하는 변수
    
    init(dataModels: [DataModel]) {
        self._dataModels = State(initialValue: dataModels)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                        .padding(.vertical)
                    LazyVGrid(columns: gridColumns) {
                        ForEach(dataModels.indices) { index in
                            if index == 0 {
                                Button(action:{
                                    isPlus = true
                                    selectedDataModel = dataModels[index]
                                }){
                                    RoundedRectangle(cornerRadius: 24)
                                        .aspectRatio(0.73, contentMode: .fit)
                                        .foregroundColor(Color(.systemGray4))
                                        .overlay (
                                            Image(systemName: "plus")
                                                .font(.largeTitle)
                                                .foregroundColor(Color(.systemOrange))
                                        )
                                }
                                .onChange(of: isPlus) { newValue in
                                    isPlus = newValue
                                }
                            } else {
                                Button(action: {
                                    selectedDataModel = dataModels[index]
                                }) {
                                CardView(dataModel: dataModels[index], isDeleting: $isDeleting)
                                    .overlay(
                                        Button(action: {
                                            isDeleting = false
                                            // 삭제 기능
                                        }){
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                                .font(.title)
                                        }
                                            .padding(10)
                                            .opacity(isDeleting ? 1 : 0)
                                        , alignment: .topLeading
                                    )
                            }
                        }
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("스누즈")
            }
            .toolbar {
                ToolbarItem(){
                    Button(isDeleting ? "완료" : "편집") {
                        isDeleting.toggle()
                    }
                    .foregroundColor(Color(.systemOrange))
                    .opacity(dataModels.isEmpty ? 0 : 1)
                }
            }
        }
        .sheet(item: $selectedDataModel) { dataModel in
            NavigationView {
                SettingView(dataModel: .constant(dataModel), isEditing: isPlus == true ? false : true)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("취소") {
                                isPlus = false
                                isDeleting = false
                                selectedDataModel = nil
                            }
                            .foregroundColor(Color(.systemOrange))
                        }
                        ToolbarItem(placement: .principal){
                            Text(isPlus == true ? "알람 추가" : "알람 편집")
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("저장") {
                                isPlus = false
                                isDeleting = false
                                selectedDataModel = nil
                            }
                            .foregroundColor(Color(.systemOrange))
                        }
                    }
                    .onAppear {
                        if selectedDataModel != nil {
                            isDeleting = false
                        }
                    }
            }
        }.tint(.orange)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(dataModels: DataModel.sampleData)
    }
}
