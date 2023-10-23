//
//  ClientRowView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/29/23.
//

import SwiftUI

struct ClientRowView: View {
    var client: Client
    var coachUID: String
    
    var name: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 35))
                    .foregroundColor(Color.gray.opacity(0.8))
            }
            VStack(alignment: .leading) {
                NavigationLink {
                    ChatChannelView(name: name)
                        .navigationTitle(name)
                        .toolbar{
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink  {
//                                    ClientFitnessProfileView(client: client, clientName: name, coachUID: coachUID)
                                    ClientFitnessProfileView(client: client, coachUID: coachUID, clientName: client.client_name)
                                } label: {
                                    Image(systemName: "person.text.rectangle")
                                }
                            }
                        }
                } label: {
                    Text(name)
                        .foregroundColor(Color(hex: 0x003049))
                        .font(.system(size: 18))
                }
                //                NavigationLink(destination: ChatChannelView(name: name)) {
                //                    Text(name)
                //                        .foregroundColor(Color(hex: 0x003049))
                //                        .font(.system(size: 18))
                //                }
            }
            Spacer()
        }
    }
}

struct ClientRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClientRowView(client: Client(client_id: "client1", client_name: "John Doe"), coachUID: "coach1", name: "Qilin")
    }
}
