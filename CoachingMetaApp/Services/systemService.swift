//
//  systemService.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/26/23.
//

import Foundation
import Alamofire
import Firebase

class SystemService: BaseService {
    struct UserRole: Codable {
        let uid: String
        let role: Int
    }
    
    struct ClientMatchInfo: Codable {
        let client_id: String
        let coach_id: String
    }
    
    struct CreateUserResponse: Codable {
        let Info: String
    }
    
    func getUserRole(completion: @escaping (Result<[UserRole], Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let url = "\(baseURL)/sys/getLoginRole/\(userID)"
        makeRequest(url: url, method: .get, completion: completion)
    }
    
    func createUserToDB(uid: String, userRole: Int, completion: @escaping (Result<CreateUserResponse, Error>) -> Void) {
        let url = "\(baseURL)/sys/createUser"
        let parameters: [String: Any] = [
            "uid": uid,
            "userRole": userRole
        ]
        
        makeRequest(url: url, method: .post, parameters: parameters, completion: completion)
    }
    
    func getUserIsMatch(completion: @escaping (Result<ClientMatchInfo, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let url = "\(baseURL)/client/getCoach/\(userID)"
        makeRequest(url: url, method: .get, completion: completion)
    }
    
    func createMatchInfo(client_id: String, coach_id: String, completion: @escaping (Result<CreateUserResponse, Error>) -> Void) {
        let url = "\(baseURL)/client/saveCoach/\(client_id)"
        let parameters: [String: Any] = [
            "coach_id": coach_id
        ]
        
        makeRequest(url: url, method: .post, parameters: parameters, completion: completion)
    }
    
    func updateMatchInfo(client_id: String, coach_id: String, completion: @escaping (Result<CreateUserResponse, Error>) -> Void) {
        let url = "\(baseURL)/client/changeCoach/\(client_id)"
        let parameters: [String: Any] = [
            "coach_id": coach_id
        ]
        
        makeRequest(url: url, method: .put, parameters: parameters, completion: completion)
    }
    
    func getClientInfo(client_id: String, completion: @escaping (Result<ClientInfo, Error>) -> Void) {
        let url = "\(baseURL)/client/getInfo/\(client_id)"
        makeRequest(url: url, method: .get, completion: completion)
    }
    
    func getCoachInfo(coach_id: String, completion: @escaping (Result<CoachInfo, Error>) -> Void) {
        let url = "\(baseURL)/coach/getInfo/\(coach_id)"
        makeRequest(url: url, method: .get, completion: completion)
    }
}
