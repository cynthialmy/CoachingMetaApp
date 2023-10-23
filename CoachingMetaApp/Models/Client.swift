//
//  Client.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/27/23.
//

import Foundation

struct Client: Codable, Identifiable {
    let id = UUID()
    let client_id: String
    let client_name: String
}
