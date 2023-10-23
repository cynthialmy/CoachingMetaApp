//
//  updateUserService.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/15/23.
//

import Foundation
import Alamofire
import Combine

class ClientService: BaseService {
    // MARK: API URLs
    let getClientInfoUrl: String = "/client/getInfo/{uid}"
    let updateClientInfoUrl: String = "/client/saveInfo/{uid}"
    let saveCoachForClientUrl: String = "/client/saveCoach/{uid}"
    let createNewWorkoutUrl: String = "/client/saveWorkout/{uid}"
    let getRecentPlanUrl: String = "/client/getRecentPlan/{uid}"
    let getPlanByDateUrl: String = "/client/getPlan/{uid}/{date}"
    let getCoachForClientUrl: String = "/client/getCoach/{uid}"
    let changeCoachUrl: String = "/client/changeCoach/{uid}"
    let getClientPlansUrl: String = "/coach/getHistory/{uid}"
    let updatePlanTasksUrl: String = "/client/updatePlan"
    
    // MARK: API response structs
    struct ClientInfo: Codable {
        let client_name: String
        let birthday: String
        let gender: String
        let height: String
        let weight: String
        let exercisePreference: Int
    }
    
    struct Workout: Codable {
        let update_date: String
        let duration: Int
        let calories: Int
        let heart_rate: Int
        let oxygen_saturation: Double
        let notes: String
    }
    
    struct PlanItem: Codable {
        let task_id: String
        let task_name: String
        let update_date: String
        let client_id: String
        let isDone: Int
        let description: String
    }
    
    struct PlanList: Codable {
        let client_id: String
        let update_date: String
        let tasks: [Task]
    }
    
    struct PostResponse: Codable {
        let Info: String?
        let Error: String?
    }
    
    struct GetCoachForClientResponse: Codable {
        let client_id: String
        let coach_id: String
    }
    
    struct ChangeCoachRequest: Codable {
        let coach_id: String
    }
    
    struct ClientPlans: Codable {
        let client_id: String
        let exerciseList: [[String: String]]
    }
    
    struct UpdateTasksResponse: Codable {
        let Info: String
    }
    
    struct UpdateClientInfo: Codable {
        let client_name: String
        let birthday: String
        let gender: String
        let height: String
        let weight: String
        let exercisePreference: Int
        
        init(client_name: String, birthday: String, gender: String, height: String, weight: String, exercisePreference: Int) {
            self.client_name = client_name
            self.birthday = birthday
            self.gender = gender
            self.height = height
            self.weight = weight
            self.exercisePreference = exercisePreference
        }
    }

    public enum Gender: String, Codable {
        case female = "Female"
        case male = "Male"
        case other = "N/A"
    }
    
    func getClientInfo(clientId: String, completion: @escaping (Result<ClientInfo, Error>) -> Void) {
        isLoading.send(true)
        let fullUrl = baseURL + getClientInfoUrl.replacingOccurrences(of: "{uid}", with: clientId)
        makeRequest(url: fullUrl, method: .get) { (result: Result<ClientInfo, Error>) in
            completion(result)
            self.isLoading.send(false)
        }
    }
    
    
    func updateClientInfo(clientId: String, clientInfo: UpdateClientInfo, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        isLoading.send(true)
        let fullUrl = baseURL + updateClientInfoUrl.replacingOccurrences(of: "{uid}", with: clientId)
        let data = try! JSONEncoder().encode(clientInfo)
        guard let parameters = dataToParameters(data: data) else { return }
        
        makeRequest(url: fullUrl, method: .post, parameters: parameters) { (result: Result<PostResponse, Error>) in
            completion(result)
            self.isLoading.send(false)
        }
    }
    
    func saveCoachForClient(uid: String, coachId: String, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        let fullUrl = baseURL + saveCoachForClientUrl.replacingOccurrences(of: "{uid}", with: uid)
        let parameters: [String: Any] = ["coach_id": coachId]
        
        makeRequest(url: fullUrl, method: .post, parameters: parameters) { (result: Result<PostResponse, Error>) in
            completion(result)
        }
    }
    
    func createNewWorkout(clientId: String, workout: Workout, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        let fullUrl = baseURL + createNewWorkoutUrl.replacingOccurrences(of: "{uid}", with: clientId)
        let data = try! JSONEncoder().encode(workout)
        guard let parameters = dataToParameters(data: data) else { return }
        
        makeRequest(url: fullUrl, method: .post, parameters: parameters) { (result: Result<PostResponse, Error>) in
            completion(result)
        }
    }
    
    func getRecentPlan(uid: String, completion: @escaping (Result<PlanList, Error>) -> Void) {
        let fullUrl = baseURL + getRecentPlanUrl.replacingOccurrences(of: "{uid}", with: uid)
        
        makeRequest(url: fullUrl, method: .get) { (result: Result<PlanList, Error>) in
            completion(result)
        }
    }
    
    func getPlanByDate(uid: String, date: String, completion: @escaping (Result<PlanList, Error>) -> Void) {
        let fullUrl = baseURL + getPlanByDateUrl.replacingOccurrences(of: "{uid}", with: uid).replacingOccurrences(of: "{date}", with: date)
        
        makeRequest(url: fullUrl, method: .get) { (result: Result<PlanList, Error>) in
            completion(result)
        }
    }
    
    func getCoachForClient(uid: String, completion: @escaping (Result<GetCoachForClientResponse, Error>) -> Void) {
        let fullUrl = baseURL + getCoachForClientUrl.replacingOccurrences(of: "{uid}", with: uid)
        
        makeRequest(url: fullUrl, method: .get) { (result: Result<GetCoachForClientResponse, Error>) in
            completion(result)
        }
    }
    
    func changeCoach(uid: String, coachId: String, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        let fullUrl = baseURL + changeCoachUrl.replacingOccurrences(of: "{uid}", with: uid)
        
        let changeCoachRequest = ChangeCoachRequest(coach_id: coachId)
        let parameters = convertToParameters(changeCoachRequest)
        
        makeRequest(url: fullUrl, method: .put, parameters: parameters, encoding: JSONEncoding.default) { (result: Result<PostResponse, Error>) in
            completion(result)
        }
    }
    
    private func convertToParameters(_ object: Encodable) -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(object)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonObject as? [String: Any]
        } catch {
            print("Failed to convert object to parameters:", error)
            return nil
        }
    }
    
    func getClientPlans(uid: String, completion: @escaping (Result<ClientPlans, Error>) -> Void) {
        let fullUrl = baseURL + getClientPlansUrl.replacingOccurrences(of: "{uid}", with: uid)
        
        makeRequest(url: fullUrl, method: .get) { (result: Result<ClientPlans, Error>) in
            switch result {
            case .success(var clientPlans):
                clientPlans = self.handleNullDescriptions(clientPlans: clientPlans)
                completion(.success(clientPlans))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func handleNullDescriptions(clientPlans: ClientPlans) -> ClientPlans {
        // Modify this function based on the actual structure of your ClientPlans model
        // Replace the exerciseList with their corresponding non-null descriptions
        var modifiedExerciseList: [[String: String]] = []
        
        for exercise in clientPlans.exerciseList {
            var modifiedExercise = exercise
            modifiedExercise["description"] = modifiedExercise["description"] ?? ""
            modifiedExerciseList.append(modifiedExercise)
        }
        
        return ClientPlans(client_id: clientPlans.client_id, exerciseList: modifiedExerciseList)
    }
    
    
    
    func updatePlanTasks(tasks: [Task], completion: @escaping (Result<String, Error>) -> Void) {
        isLoading.send(true)
        let fullUrl = baseURL + updatePlanTasksUrl
        let parameters: [String: Any] = ["tasks": tasks.map { ["task_id": $0.task_id, "isDone": $0.isDone] }]
        
        makeRequest(url: fullUrl, method: .put, parameters: parameters) { (result: Result<UpdateTasksResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.Info))
            case .failure(let error):
                completion(.failure(error))
            }
            self.isLoading.send(false)
        }
    }
    
}
