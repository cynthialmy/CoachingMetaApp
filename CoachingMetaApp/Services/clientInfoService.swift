//
//  updateUserService.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/15/23.
//

import Foundation
import Alamofire
import Combine

class ClientService: ObservableObject {
    //MARK: Service specific variables
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    // MARK: API URLs
    var getClientInfoUrl: String = "http://localhost:6601/getClientInfo/{clientId}"
    var getDailyProgressUrl: String = "http://localhost:6601/getDailyProgress/{clientId}"
    var updateClientInfoUrl: String = "http://localhost:6601/updateClientInfo/{clientId}"
    var createNewWorkOutUrl: String = "http://localhost:6601/createWorkout/{clientId}"
    var postEodWorkout: String =  "http://localhost:6601/postEodWorkout/{clientId}"
    
    // MARK: API response structs
    var clientInfoResponse: ClientInfo?
    var dailyProgress: Workout?
    var updateClientResponse: PostResponse?
    var createWorkoutResponse: PostResponse?
    var postEodWorkResponse: PostResponse?
    
    func getClientInfo(clientId: String, completion: @escaping (Result<ClientInfo, Error>) -> Void) {
        let fullUrl = getClientInfoUrl.replacingOccurrences(of: "{clientId}", with: clientId)
        let request = AF.request(fullUrl)
        request.responseDecodable(of: ClientInfo.self) { response in
            switch response.result {
            case .success(let clientInfo):
                completion(.success(clientInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDailyProgress(clientId: String, completion: @escaping (Result<Workout, Error>) -> Void) {
        let fullUrl = getDailyProgressUrl.replacingOccurrences(of: "{clientId}", with: clientId)
        let request = AF.request(fullUrl)
        request.responseDecodable(of: Workout.self) { response in
            switch response.result {
            case .success(let dailyProgress):
                completion(.success(dailyProgress))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateClientInfo(clientId: String, name: String, height: String, weight: String, gender: String, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        isLoading.send(true)
        let fullUrl = updateClientInfoUrl.replacingOccurrences(of: "{clientId}", with: clientId)
        let parameters: [String: Any] = ["name": name, "height": height, "weight": weight, "gender": gender]
        AF.request(fullUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: PostResponse.self) { response in
            switch response.result {
            case .success(let updateResponse):
                completion(.success(updateResponse))
            case .failure(let error):
                completion(.failure(error))
            }
            self.isLoading.send(false)
        }
    }
    
    ///  Service call to create a new work out plan in the DB
    ///  - Parameters:
    ///     - value: TODO
    ///  ```
    ///  Discussion
    ///  ```
    ///  - Returns: void
    func createNewWorkout(clientId: String, workoutData: [String: Any], completion: @escaping (Result<PostResponse, Error>) -> Void) {
        let fullUrl = createNewWorkOutUrl.replacingOccurrences(of: "{clientId}", with: clientId)
        AF.request(fullUrl, method: .post, parameters: workoutData, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: PostResponse.self) { response in
            switch response.result {
            case .success(let createResponse):
                completion(.success(createResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Service call to post the workout progress at the end of the day.
    /// - Parameters:
    /// - Returns: void
    func postEndOfDayHealthData(clientId: String, payload: HealthData, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        let date = "some date string"
        let fullUrl = postEodWorkout.replacingOccurrences(of: "{clientId}", with: clientId)
        let parameters: [String: Any] = [
            "clientId": clientId,
            "steps": payload.totalSteps ?? 0,
            "distance": payload.totalDistance ?? 0,
            "calories": payload.totalCalories ?? 0,
            "duration": payload.totalDuration ?? 0,
            "date": date
        ]
        
        AF.request(fullUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: PostResponse.self) { response in
            switch response.result {
            case .success(let postEodResponse):
                completion(.success(postEodResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getResult(of api: String) -> ApiResponse {
        switch api {
        case "dailyProgress":
            return dailyProgress ?? Workout()
        default:
            return Workout()
        }
        
    }
    
    public func getLoading() -> AnyPublisher<Bool, Never> {
        isLoading.eraseToAnyPublisher()
    }
}
