//
//  ApiResponse.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/19/23.
//

import Foundation

protocol ApiResponse {
    var status: String? { get }
    var statusMessage: String? { get }
}
