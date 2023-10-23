//
//  PlanList.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/14/23.
//

import Foundation

class PlanList: ObservableObject {
    @Published var items: [Task] = []
    
    init(plan: Plan) {
        for task in plan.tasks {
            let newTask = Task(task_id: task.task_id, task_name: task.task_name, update_date: task.update_date, client_id: task.client_id, isDone: task.isDone, description: task.description)
            items.append(newTask)
        }
    }
    
    func deleteItems(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func updateItems(item: Task) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = Task(task_id: item.task_id, task_name: item.task_name, update_date: item.update_date, client_id: item.client_id, isDone: item.isDone, description: item.description)
        }
    }
}
