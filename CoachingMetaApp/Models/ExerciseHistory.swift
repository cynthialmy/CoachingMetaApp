//
//  ExerciseHistory.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/26/23.
//

import Foundation

struct ExerciseHistory: Codable {
    let clientId: String
    let exerciseList: [Exercise]

    struct Exercise: Codable {
        let date: String
    }
}
