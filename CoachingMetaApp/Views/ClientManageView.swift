//
//  ClientManageView.swift
//  CoachingMetaApp
//
//  Created by Qilin Li on 3/29/23.
//  UNUSED

import SwiftUI

struct ClientManageView: View {
    
    var body: some View {
        let details: [String] = [
            "Qilin Li", "Mengyuan Li", "Xianyi Nie", "Guanming Chen"
            ]
        VStack {
            Text("My Clients").font(.system(size: 25))
//            ClientListView(names: details)
        }
    }
}

struct ClientManageView_Previews: PreviewProvider {
    static var previews: some View {
        ClientManageView()
    }
}
