//
//  CoachInfo.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/24/23.
//

import Foundation

struct CoachInfo: Codable {
    let coach_name: String
    let birthday: String
    let gender: String
    let height: String
    let weight: String
    let coaching_experience: Int
    let specialization: String
}
