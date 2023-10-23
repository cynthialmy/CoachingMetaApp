//
//  Plan.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/26/23.
//

import Foundation

struct Plan: Codable {
    let client_id: String
    let update_date: String
    var tasks: [Task]
}

