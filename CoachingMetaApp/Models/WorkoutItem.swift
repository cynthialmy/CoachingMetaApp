//
//  WorkoutItem.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/13/23.
//

import Foundation

class WorkoutItems: ObservableObject {
    @Published var workoutItems: [Workout] = []
}
