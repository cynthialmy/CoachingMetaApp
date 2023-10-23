//
//  postNewPlanViewModel.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/25/23.
//

import Foundation

class PostNewPlanViewModel: ObservableObject {
    // MARK: variables
    var api: ClientService = ClientService()
    var coach_api: CoachService = CoachService()
}

// MARK: API calls
extension PostNewPlanViewModel {
    ///

    func getPlan(uid: String) {
        api.getRecentPlan(uid: uid) { result in
            switch result {
            case .success(let getResponse):
                print(getResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // TODO:
    func addNewPlan(uid: String, plan: Plan) {
        coach_api.postNewPlan(clientUID: uid, plan: plan) { result in
            switch result {
            case .success(let Response):
                print(Response)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

// MARK: Subscriptions
extension PostNewPlanViewModel {
    
}
