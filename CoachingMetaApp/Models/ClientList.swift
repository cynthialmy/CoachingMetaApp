//
//  ClientList.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/27/23.
//

import Foundation

struct ClientList: Codable {
    let coach_id: String
    let clientList: [Client]
}
