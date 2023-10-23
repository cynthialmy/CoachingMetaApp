//
//  myPlansViewModel.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/25/23.
//

import Foundation
import Combine

class MyPlansViewModel: ObservableObject {
    // MARK: viewModel variables
    var clientService: ClientService = ClientService()
    @Published var isLoading: Bool = false
    private var listOfDates: ClientService.ClientPlans?
    public private(set) var planListResponse: PlanList?
    public private(set) var plans: [Plan] = []

    init() {
       getListOfDates(uid: userID) // if testing, use client1 as uid
    }
}

// MARK: API calls
extension MyPlansViewModel {
    func getListOfDates(uid: String)  {
        isLoading = true
        clientService.getClientPlans(uid: uid) { result in
            switch result {
            case .success(let success):
                print("list of dates: ", success)
                self.listOfDates = success
                guard let list = self.listOfDates else { return }
                self.getPlanByDateAsync(exerciseList: list.exerciseList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPlanByDateAsync(exerciseList: [[String: String]]) {
        let myGroup = DispatchGroup()
        for task in exerciseList {
            myGroup.enter()
            //pass in task["update_date"] ?? "" for date parameter
            clientService.getPlanByDate(uid: userID, date: task["update_date"] ?? "") { result in
                switch result {
                case .success(let success):
                    let plan = Plan(client_id: success.client_id, update_date: success.update_date, tasks: success.tasks)
                    self.plans.append(plan)
                    print("\npushed plan: \n", self.plans)
                case .failure(let error):
                    print(error)
                }
                myGroup.leave()
            }
        }
        myGroup.notify(queue: .main) {
            print("Finished all requests to get plans by date")
            self.isLoading = false
        }
    }
}

//MARK: helper functions
extension MyPlansViewModel {
    func toDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        let convertedDate = dateFormatter.date(from: date)
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: convertedDate ?? Date.now)
    }
}
