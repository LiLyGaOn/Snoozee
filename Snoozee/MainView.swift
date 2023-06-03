//
//  MainView.swift
//  Snoozee
//
//  Created by xnoag on 2023/06/02.
//

import SwiftUI

struct MainView: View {
    var dataModels: [DataModel]
    @State var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(dataModels) { dataModel in
                        CardView(dataModel: dataModel)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("스누즈")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(dataModels: DataModel.sampleData)
    }
}
