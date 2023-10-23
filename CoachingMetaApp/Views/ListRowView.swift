//
//  ListView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/8/23.
//

import SwiftUI

struct ListRowView: View {
    let task: Task
    @ObservedObject var viewModel: FitnessDataViewModel
    
    // Add this state variable
    @State private var isDone: Bool
    
    init(task: Task, viewModel: FitnessDataViewModel) {
        self.task = task
        self.viewModel = viewModel
        self._isDone = State(initialValue: task.isDone == 1)
        print("task",task)
    }
    
    
    var body: some View {
        HStack {
            Image(systemName: isDone ? "checkmark.circle" : "circle")
                .foregroundColor(isDone ? Color(hex: 0xf77f00) : .gray)
//            Spacer()
            Text(task.task_name)
                .strikethrough(isDone, color: Color(hex: 0xf77f00))
                .foregroundColor(isDone ? Color(hex: 0xf77f00) : .black)
        }
//        .padding(90)
        .contentShape(Rectangle())
        .onTapGesture {
            isDone.toggle()
            viewModel.toggleTaskIsDone(task: task)
        }
    }
}


struct ListRowView_Previews: PreviewProvider {
    static var task1 = Task(task_id: "1", task_name: "item1", update_date: "", client_id: "", isDone: 1, description: "")
    static var task2 = Task(task_id: "2", task_name: "item2", update_date: "", client_id: "", isDone: 0, description: "")
    static var previews: some View {
        Group {
            ListRowView(task: task1, viewModel: SampleFitnessDataViewModel())
            ListRowView(task: task2, viewModel: SampleFitnessDataViewModel())
        }.previewLayout(.sizeThatFits)
    }
}


