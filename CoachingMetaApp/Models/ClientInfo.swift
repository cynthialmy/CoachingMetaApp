//
//  UpdateUserServiceResponse.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/16/23.
//

import Foundation

struct ClientInfo: Codable {
    let client_name: String
    let birthday: String
    let gender: String
    let height: String
    let weight: String
    let exercisePreference: Int
}

public enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case other = "N/A"
}
