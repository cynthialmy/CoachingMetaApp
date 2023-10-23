//
//  CoachInfoView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/27/23.
//

import SwiftUI

struct CoachInfoView: View {
    @StateObject private var viewModel = CoachInfoViewModel(coach_id: userID)
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Name")
                    Spacer().frame(width: 20)
                    TextField("\(viewModel.coach_name)", text: $viewModel.coach_name)
                }
                HStack {
                    Text("Birthday")
                    Spacer().frame(width: 20)
//                    TextField
                }
//                DatePicker("Birthday", selection: $birthday, in: ...(currentClientInfo.birthday.toDate() ?? Date.now), displayedComponents: .date)
//                    .onChange(of: birthday) { newValue in
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "yyyy-MM-dd"
//                        viewModel.birthday = dateFormatter.string(from: newValue)
//                    }
//                Picker("Gender", selection: $gender) {
//                    Text("Female").tag(Gender.female.rawValue)
//                    Text("Male").tag(Gender.male.rawValue)
//                    Text("N/A").tag(Gender.other.rawValue)
//                }.onChange(of: gender, perform: { value in
//                    viewModel.gender = value.rawValue
//                })
                HStack {
                    Text("Weight (kg)")
                    Spacer().frame(width: 20)
                    
                }
                HStack {
                    Text("Height (m)")
                    Spacer().frame(width: 20)
                    
                }
                HStack {
                    Text("Coaching experience")
                    Spacer().frame(width: 20)
                }
                HStack {
                    Text("Specialization")
                    Spacer().frame(width: 20)
                }
            }
            Button {
                
            } label: {
                Text("UPDATE").font(.system(size: 23))
            }.padding()
        }.ignoresSafeArea(.keyboard)
    }
}

struct CoachInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CoachInfoView()
    }
}
