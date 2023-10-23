//
//  FitnessDataViewModel.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/24/23.
//

import Foundation

class FitnessDataViewModel: ObservableObject {
    @Published var oxygenSaturation: String = ""
    @Published var heartRate: String = ""
    @Published var calories: String = ""
    @Published var duration: String = ""
    @Published var note: String = ""
    @Published var tasks: [Task] = [] // Add tasks property
    @Published var exerciseList: [[String: String]] = []
    
    private var clientService = ClientService()
    private var coachService = CoachService()
    private var uid: String? {
        didSet {
            if uid == nil {
                print("User not authenticated")
            }
        }
    }
    
    init() {
        uid = BaseService().getUID()
    }
}

extension FitnessDataViewModel {
    // Function to create a new workout
    func createWorkout() {
        if let uid = self.uid {
            let workout = ClientService.Workout(
                update_date: "", // may want to replace this with the actual date
                duration: Int(duration) ?? 0,
                calories: Int(calories) ?? 0,
                heart_rate: Int(heartRate) ?? 0,
                oxygen_saturation: Double(oxygenSaturation) ?? 0.0,
                notes: note
            )
            
            
            clientService.createNewWorkout(clientId: uid, workout: workout) { result in
                switch result {
                case .success(let response):
                    print("Workout created successfully: \(response)")
                case .failure(let error):
                    print("Error creating workout: \(error)")
                }
            }
        } else {
            print("User not authenticated")
        }
    }
    
    // Function to get tasks
    func getTasks() {
        if let uid = self.uid {
            clientService.getRecentPlan(uid: uid) { result in
                switch result {
                case .success(let planList):
                    self.tasks = planList.tasks
                case .failure(let error):
                    print("Error fetching tasks: \(error)")
                }
            }
        } else {
            print("User not authenticated")
        }
    }
    
    // function to get all history
    func getHistory(client_id: String) {
        if let uid = self.uid{
            coachService.getExerciseHistory(clientUID: client_id) { result in
                switch result {
                case .success(let historyResponse):
                    self.exerciseList = historyResponse.exerciseList
                    print("count: \(self.exerciseList.count)")
                    for element in self.exerciseList {
                        for (key, value) in element {
                            print("\(key):\(value)")
                        }
                    }
                case .failure(let error):
                    print("Error fetching tasks: \(error)")
                }
           
            }
        }
        
    }
    // Function to update tasks
    func updateTasks(tasks: [Task]) {
        // Replace "client_id" with the actual client ID
        if let uid = self.uid {
            // Toggle the isDone property of each task
            let updatedTasks = tasks.map { task -> Task in
                return Task(
                    task_id: task.task_id,
                    task_name: task.task_name,
                    update_date: task.update_date,
                    client_id: task.client_id,
                    isDone: task.isDone == 0 ? 0 : 1,
                    description: task.description
                )
            }
            
            // Update the tasks in the database
            clientService.updatePlanTasks(tasks: updatedTasks) { result in
                switch result {
                case .success(let result):
                    print(result)
                    // Refresh the task list
                    self.getTasks()
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            print("User not authenticated")
        }
    }
    
    func toggleTaskIsDone(task: Task) {
        if let index = tasks.firstIndex(where: { $0.task_id == task.task_id }) {
            tasks[index].isDone = tasks[index].isDone == 0 ? 1 : 0
        }
    }
    
}
