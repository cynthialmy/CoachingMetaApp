//
//  ClientPlanListView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/14/23.
//

import SwiftUI

struct ClientPlanListView: View {
    @StateObject var viewModel = MyPlansViewModel()

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                LoadingDots()
            } else {
                ForEach(0..<viewModel.plans.count, id: \.self) { index in
                    ClientPlanRowView(viewModel: viewModel, plan: viewModel.plans[index])
                }
            }
        }.padding()
    }
}

struct ClientPlanListView_Previews: PreviewProvider {
    static var previews: some View {
        ClientPlanListView()
    }
}
