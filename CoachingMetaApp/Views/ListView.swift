//
//  ListView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/8/23.
//


import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel = FitnessDataViewModel()
    
    var body: some View {
        VStack {
            Group {
                ForEach(viewModel.tasks) { task in
                    ListRowView(task: task,viewModel: SampleFitnessDataViewModel())
                }
            }.listStyle(PlainListStyle()) // prevent scroll view..
        }.onAppear {
            viewModel.getTasks()
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView(viewModel: SampleFitnessDataViewModel())
        }
    }
}

class SampleFitnessDataViewModel: FitnessDataViewModel {
    override init() {
        super.init()
        tasks = [
            Task(task_id: "1", task_name: "Sample Task 1", update_date: "2023-04-27", client_id: "1", isDone: 0, description: "Sample task description 1"),
            Task(task_id: "2", task_name: "Sample Task 2", update_date: "2023-04-27", client_id: "2", isDone: 1, description: "Sample task description 2"),
            Task(task_id: "3", task_name: "Sample Task 3", update_date: "2023-04-27", client_id: "3", isDone: 0, description: "Sample task description 3"),
            Task(task_id: "4", task_name: "Sample Task 4", update_date: "2023-04-27", client_id: "4", isDone: 1, description: "Sample task description 4")
        ]
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
