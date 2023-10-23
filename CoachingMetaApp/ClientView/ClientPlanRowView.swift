//
//  ClientPlanRowView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/14/23.
//

import SwiftUI

struct ClientPlanRowView: View {
    @ObservedObject var viewModel: MyPlansViewModel
    var plan: Plan

    var body: some View {
        VStack {
            NavigationLink {
                PlanPreviewView(viewModel: viewModel, plan: plan)
            } label: {
                Text("Plans on \n\(viewModel.toDate(date: plan.update_date))")
                    .font(.system(size:20))
                    .foregroundColor(
                        Color(hex: 0x003049, opacity: 0.5))
                    .bold()
            }
        }.frame(width: 360, height: 100)
            .background(Color(hex: 0xeae2b7, opacity: 0.3))
            .cornerRadius(17.0)
    }
}

