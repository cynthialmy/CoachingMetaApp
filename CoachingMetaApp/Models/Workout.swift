//
//  Workout.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/13/23.
//

import Foundation

struct Workout: Codable {
    let update_date: String
    let duration: Int
    let calories: Int
    let heart_rate: Int
    let oxygen_saturation: Double
    let notes: String
}
