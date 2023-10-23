//
//  coachService.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/26/23.
//

import Foundation
import Alamofire
import Combine

class CoachService: BaseService {
    
    // Structs for decoding JSON responses
    struct CoachInfo: Codable {
        let coach_name: String
        let birthday: String
        let gender: String
        let height: String
        let weight: String
        let coaching_experience: Int
        let specialization: String
    }
    
    struct ClientList: Codable {
        let coach_id: String
        let clientList: [[String: String]]
    }
    
    struct ClientPlans: Codable {
        let client_id: String
        let exerciseList: [[String: String]]
    }
    
    struct WorkoutForClient: Codable {
        let client_id: String
        let update_date: String
        let duration: Int
        let oxygen_saturation: Double
        let heart_rate: Int
        let calories: Int
        let notes: String
    }
    
    func getCoachInfo(uid: String, completion: @escaping (Result<CoachInfo, Error>) -> Void) {
        let url = baseURL + "/coach/getInfo/\(uid)"
        makeRequest(url: url, method: .get) { (result: Result<CoachInfo, Error>) in
            completion(result)
        }
    }
    
    func updateCoachInfo(coachID: String, info: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/coach/saveInfo/\(coachID)"
        makeRequest(url: url, method: .post, parameters: info) { (result: Result<Data?, Error>) in
            completion(result.map { _ in () })
        }
    }
    
    func getClientList(uid: String, completion: @escaping (Result<ClientList, Error>) -> Void) {
        let url = baseURL + "/coach/getClients/\(uid)"
        makeRequest(url: url, method: .get) { (result: Result<ClientList, Error>) in
            completion(result)
        }
    }
    
    func postNewPlan(clientUID: String, plan: Plan, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/coach/savePlan/\(clientUID)"
        
        var modifiedPlan = plan
        modifiedPlan.tasks = plan.tasks.map { task in
            var modifiedTask = task
            modifiedTask.task_id = UUID().uuidString // Generate a task_id using UUID
            return modifiedTask
        }
        
        let parameters = planToParameters(plan: modifiedPlan) // Convert the modified plan to parameters
        print("parameters\(parameters)")
        makeRequest(url: url, method: .post, parameters: parameters) { (result: Result<Data?, Error>) in
            completion(result.map { _ in () })
        }
    }
    
    private func planToParameters(plan: Plan) -> [String: Any] {
        // Convert the plan object to parameters
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        guard let data = try? encoder.encode(plan),
              let parameters = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return [:]
        }
        
        return parameters
    }
    
    func getClientPlans(clientUID: String, completion: @escaping (Result<ClientPlans, Error>) -> Void) {
        let url = baseURL + "/coach/getHistory/\(clientUID)"
        makeRequest(url: url, method: .get) { (result: Result<ClientPlans, Error>) in
            completion(result)
        }
    }
    
    func getExerciseHistory(clientUID: String, completion: @escaping (Result<ClientPlans, Error>) -> Void) {
        let url = baseURL + "/coach/getHistory/\(clientUID)"
        makeRequest(url: url, method: .get) { (result: Result<ClientPlans, Error>) in
            completion(result)
        }
    }
    
    func getWorkoutForClient(clientUID: String, date: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let url = baseURL + "/coach/getWorkout/\(clientUID)/\(date)"
        makeRequest(url: url, method: .get) { (result: Result<WorkoutForClient, Error>) in
            switch result {
            case .success(let WorkoutForClient):
                let data = [
                    "client_id": WorkoutForClient.client_id,
                    "update_date": WorkoutForClient.update_date,
                    "duration": WorkoutForClient.duration,
                    "oxygen_saturation": WorkoutForClient.oxygen_saturation,
                    "heart_rate": WorkoutForClient.heart_rate,
                    "calories": WorkoutForClient.calories,
                    "notes": WorkoutForClient.notes
                ]
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
