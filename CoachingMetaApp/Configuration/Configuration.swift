//
//  Configuration.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 3/9/23.
//

import Foundation

struct API {

    static let APIKey = "511e7c989f532857b131bae5f4c1b186"
    static let BaseURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast")!
    // api.openweathermap.org/data/2.5/forecast?id=524901&appid={API key}

    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }

}

struct Defaults {

    static let Latitude: Double = 37.8267
    static let Longitude: Double = -122.423

}
