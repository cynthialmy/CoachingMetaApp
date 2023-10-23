//
//  Task.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/27/23.
//

import Foundation

struct Task: Codable, Identifiable {
    var id: String { task_id }
    var task_id: String
    let task_name: String
    let update_date: String
    let client_id: String
    var isDone: Int
    let description: String
}
