//
//  PlanPreviewView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/15/23.
//

import SwiftUI

struct PlanPreviewView: View {
    @ObservedObject var viewModel: MyPlansViewModel
    var plan: Plan

    var body: some View {
        VStack {
            List {
                ForEach(0..<plan.tasks.count, id: \.self) { index in
                    taskDetails(plan.tasks[index])
                }
            }.listStyle(PlainListStyle())
        }
    }

    @ViewBuilder private func taskDetails(_ task: Task) -> some View {
        VStack(alignment: .leading) {
            Text(task.task_name)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(Color(hex: 0xf77f00))
            Text(task.description)
                .foregroundColor(Color(hex: 0x003049))
        }.padding()
    }
}
