//
//  coachInfoViewModel.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/25/23.
//

import Foundation

class CoachInfoViewModel: ObservableObject {
    @Published var coach_name: String = ""
    @Published var birthday: String = ""
    @Published var gender: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var coaching_experience: Int = 0
    @Published var specialization: String = ""
    
    var api: CoachService = CoachService()
    var coachInfo: CoachService.CoachInfo?
    @Published var isLoading: Bool = false
    let coach_id: String
    
    init(coach_id: String) {
        self.coach_id = coach_id
        subscribeToUpdateCoachInfo()
        getCoachData()
    }
}

extension CoachInfoViewModel {
    func getCoachData() {
        api.getCoachInfo(uid: coach_id, completion: { result in
            switch result {
            case .success(let coachInfo):
                self.coachInfo = coachInfo
                self.updateViewValues()
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
    
    func updateCoachInfo(coachInfo: [String: Any]) {
        api.updateCoachInfo(coachID: coach_id, info: coachInfo, completion: { result in
            switch result {
            case .success(let postResponse):
                print("Update Coach info response:", postResponse)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        })
    }
    
    func subscribeToUpdateCoachInfo() {
        api.getLoading()
            .dropFirst()
            .receive(on: RunLoop.main)
            .assign(to: &$isLoading)
    }
    
    func updateViewValues() {
        if let coachInfo = self.coachInfo {
            self.coach_name = coachInfo.coach_name
            self.birthday = coachInfo.birthday
            self.gender = coachInfo.gender
            self.height = coachInfo.height
            self.weight = coachInfo.weight
            self.coaching_experience = coachInfo.coaching_experience
            self.specialization = coachInfo.specialization

        }
    }
    
}
