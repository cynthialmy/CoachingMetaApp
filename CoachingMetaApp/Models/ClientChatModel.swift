//
//  ClientChatModel.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/20/23.
//

import Foundation
struct ClientChatModel: Identifiable, Hashable {
    let id: String
    
    let name: String
    let activeTime: String
    let chatHistories: [String]
    
    init(id: String = UUID().uuidString, name: String, activeTime: String, ChatHistories: [String]) {
        self.id = id
        self.name = name
        self.activeTime = activeTime
        self.chatHistories = ChatHistories
    }

}
