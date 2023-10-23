//
//  HealthData.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/20/23.
//

import Foundation

struct HealthData: Decodable, ApiResponse {
    var status: String?
    var statusMessage: String?
    var totalSteps: Int?
    var totalDistance: Int?
    var totalCalories: Int?
    var totalDuration: Int?
}

let sampleHealthData = HealthData(
    status: "SUCCESS",
    statusMessage: "",
    totalSteps: 12000,
    totalDistance: 8,
    totalCalories: 500,
    totalDuration: 60
)
