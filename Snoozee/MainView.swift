//
//  MainView.swift
//  Snoozee
//
//  Created by xnoag on 2023/06/02.
//

import SwiftUI
import UIKit

struct MainView: View {
    @Binding var dataModels: [DataModel]
    @Environment(\.scenePhase) private var scenePhase
    @State var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    @State var selectedDataModel: DataModel? = nil
    @State var isLongPressed: Bool = false
    @State var isSelected: [Bool]
    @State var isPlus: Bool? = nil
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    @State var cardOffset: CGSize = .zero // 추가: 카드 위치를 조정하는 변수
    let saveAction: ()->Void
    
    init(dataModels: [DataModel]) {
        self._dataModels = State(initialValue: dataModels)
        self._isSelected = State(initialValue: Array(repeating: false, count: dataModels.count))
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
                                CardView(dataModel: dataModels[index], isLongPressed: $isLongPressed)
                                    .overlay(
                                        Button(action: {
                                            isLongPressed = false
                                            // 삭제 기능
                                        }){
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                                .font(.title)
                                        }
                                            .padding(10)
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
                                                feedbackGenerator.prepare() // 햅틱 효과를 준비
                                                feedbackGenerator.impactOccurred() // 햅틱 효과 발생
                                                withAnimation(.easeInOut(duration: 0.2)) {
                                                    // 애니메이션을 적용할 코드
                                                    isSelected[index] = false
                                                    isLongPressed = true
                                                    // 카드를 좌우로 이동시키는 애니메이션
                                                    if isLongPressed {
                                                        cardOffset = CGSize(width: 10, height: 0) // 오른쪽으로 이동
                                                    } else {
                                                        cardOffset = .zero // 원래 위치로 복귀
                                                    }
                                                }
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
        .sheet(item: $selectedDataModel) { dataModel in
            NavigationView {
                SettingView(dataModel: .constant(dataModel), isEditing: isPlus == true ? false : true)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("취소") {
                                isPlus = false
                                isLongPressed = false
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
                                isLongPressed = false
                                selectedDataModel = nil
                            }
                            .foregroundColor(Color(.systemOrange))
                        }
                    }
                    .onAppear {
                        if selectedDataModel != nil {
                            isLongPressed = false
                        }
                    }
            }
        }
        .tint(.orange)
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(dataModels: DataModel.sampleData, saveAction: {})
    }
}
