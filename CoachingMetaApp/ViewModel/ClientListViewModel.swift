//
//  clientListViewModel.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/25/23.
//

import Foundation

class ClientListViewModel: ObservableObject {
    @Published var clients: [Client] = []
    @Published var workoutData: [String: Any] = [:]
    
    let coachUID: String
    
    init(coachUID: String) {
        self.coachUID = coachUID
        fetchClientList(coachUID: coachUID)
    }
    
    
    func fetchClientList(coachUID: String) {
        let coachService = CoachService()
        coachService.getClientList(uid: coachUID) { result in
            switch result {
            case .success(let clientList):
                self.clients = clientList.clientList.map { clientData in
                    let clientID = clientData["client_id"] ?? ""
                    let clientName = clientData["client_name"] ?? ""
                    
                    return Client(client_id: clientID, client_name: clientName)
                }
            case .failure(let error):
                print("Error fetching client list: \(error)")
            }
        }
    }
    
    func getWorkoutForClient(clientUID: String, date: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let service = CoachService()
        service.getWorkoutForClient(clientUID: clientUID, date: date) { result in
            switch result {
            case .success(let workout):
                completion(.success(workout))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func datesBetween(start: Date, end: Date) -> [Date] {
        guard start <= end else { return [] }
        
        var dates: [Date] = []
        var currentDate = start
        
        let calendar = Calendar.current
        while currentDate <= end {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
    func calculateAverageWorkoutTime(clientUID: String, startDate: String, endDate: String, completion: @escaping (Double) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let start = dateFormatter.date(from: startDate),
              let end = dateFormatter.date(from: endDate) else {
            print("Invalid date format")
            return
        }
        
        let dates = datesBetween(start: start, end: end)
        
        var totalDuration = 0
        var fetchedWorkouts = 0
        
        let dispatchGroup = DispatchGroup()
        
        for date in dates {
            let dateString = dateFormatter.string(from: date)
            
            dispatchGroup.enter()
            
            getWorkoutForClient(clientUID: clientUID, date: dateString, completion: { result in
                switch result {
                case .success(let workout):
                    if let duration = workout["duration"] as? Int {
                        totalDuration += duration
                    }
                    fetchedWorkouts += 1
                    dispatchGroup.leave()
                case .failure(let error):
                    print("Error fetching workout data: \(error)")
                    dispatchGroup.leave()
                }
            })
            
        }
        
        dispatchGroup.notify(queue: .main) {
            let averageWorkoutTime = fetchedWorkouts == 0 ? 0 : Double(totalDuration) / Double(fetchedWorkouts)
            completion(averageWorkoutTime)
        }
    }
    
}
