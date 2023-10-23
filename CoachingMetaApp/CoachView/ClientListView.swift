//
//  ClientListView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/29/23.
//

import SwiftUI

struct ClientListView: View {
    @StateObject private var viewModel: ClientListViewModel
    let coachUID: String // Provide the coach UID
    
    init(coachUID: String) {
        self.coachUID = coachUID
        _viewModel = StateObject(wrappedValue: ClientListViewModel(coachUID: coachUID))
    }
    
    var body: some View {
        List(viewModel.clients) { client in
            ClientRowView(client: client, coachUID: coachUID, name: client.client_name)
                .frame(height: 37)
        }
        .background(Color.gray.opacity(0.1))
        .onAppear {
            viewModel.fetchClientList(coachUID: coachUID)
        }
    }
}

struct ClientListView_Previews: PreviewProvider {
    static var previews: some View {
        ClientListView(coachUID: "coach1")
    }
}
