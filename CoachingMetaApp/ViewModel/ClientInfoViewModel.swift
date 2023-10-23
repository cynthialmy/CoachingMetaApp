//
//  ClientInfoViewModel.swift
//  CoachingMetaApp
//
//  Created by Mengyuan Li on 4/16/23.
//


import Foundation
import SwiftUI

class ClientInfoViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var gender: String = ""
    @Published var birthday: String = ""
    @Published var exercisePreference: Int = 0
    
    var api: ClientService = ClientService()
    var clientInfo: ClientService.ClientInfo?
    @Published var isLoading: Bool = false
    let clientId: String
    
    init(clientId: String) {
        self.clientId = clientId
        subscribeToUpdateClientInfo()
        getClientData()
    }
}

// MARK: api calls
extension ClientInfoViewModel {
    
    func getClientData() {
        api.getClientInfo(clientId: clientId, completion: { result in
            switch result {
            case .success(let clientInfo):
                self.clientInfo = clientInfo
                self.updateViewValues()
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }

    func updateClientInfo(updateClientInfo: ClientService.UpdateClientInfo) {
        api.updateClientInfo(clientId: clientId, clientInfo: updateClientInfo, completion: { result in
            switch result {
            case .success(let postResponse):
                print("Update client info response:", postResponse)
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}

// MARK: api subscriptions
extension ClientInfoViewModel {
    func subscribeToUpdateClientInfo() {
        api.getLoading()
            .dropFirst()
            .receive(on: RunLoop.main)
            .assign(to: &$isLoading)
    }
}

// MARK: helper functions
extension ClientInfoViewModel {
    func updateViewValues() {
        if let clientInfo = self.clientInfo {
            self.name = clientInfo.client_name
            self.weight = "\(clientInfo.weight)"
            self.height = "\(clientInfo.height)"
            self.gender = clientInfo.gender
        }
    }
}
