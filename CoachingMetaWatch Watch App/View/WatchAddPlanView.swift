//
//  WatchAddPlanView.swift
//  CoachingMetaWatch Watch App
//
//  Created by Sicilia Li on 4/25/23.
//

import SwiftUI

struct WatchAddPlanView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            ListView().listStyle(PlainListStyle())
                .padding()
                .font(.system(size: 16))
                .offset(y: -10)
            Spacer()
            Button {
                // submit task
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Submit")
            }.background(orange).cornerRadius(20).frame(width: 100).offset(y: 87)
        }
    }
}

struct WatchAddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WatchAddPlanView()
        }
    }
}
