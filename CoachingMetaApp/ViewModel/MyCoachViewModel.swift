//
//  MyCoachViewModel.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/25/23.
//

import Foundation

class MyCoachViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var gender: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var coachingExperience: String = ""
    @Published var specialization: String = ""
    
    func fetchCoachInfo(uid: String) {
        let coachService = CoachService()
        coachService.getCoachInfo(uid: uid) { result in
            switch result {
            case .success(let coachInfo):
                self.name = coachInfo.coach_name
                if let age = coachInfo.birthday.age() {
                    self.age = "\(age)"
                } else {
                    self.age = "N/A"
                }
                self.gender = coachInfo.gender
                self.height = coachInfo.height
                self.weight = coachInfo.weight
                self.coachingExperience = "\(coachInfo.coaching_experience)"
                self.specialization = coachInfo.specialization
            case .failure(let error):
                print("Error fetching coach information: \(error)")
            }
        }
    }
}
