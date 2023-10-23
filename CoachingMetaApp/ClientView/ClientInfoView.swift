//
//  ClientInfoView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/10/23.
//

import SwiftUI

// convert "mmddyy" to Date() type in Swift
extension String {
    func toDate(format: String = "MMddyyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}


struct ClientInfoView: View {
    
    @StateObject var viewModel = ClientInfoViewModel(clientId: "sample_client_id")
    
    @State var seePlan: Bool = false
    @State var weight = ""
    @State var height = ""
    @State var name = ""
    @State var gender: Gender = .other
    @State var preference = 0
    @State private var birthday = Date.now
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if viewModel.isLoading {
            VStack {
                Spacer()
                LoadingDots()
            }
        } else {
            VStack {
                List {
                    HStack {
                        Text("Name")
                        Spacer().frame(width: 20)
                        TextField("\(currentClientInfo.client_name)", text: $viewModel.name)
                    }
                    DatePicker("Birthday", selection: $birthday, in: ...(currentClientInfo.birthday.toDate() ?? Date.now), displayedComponents: .date)
                        .onChange(of: birthday) { newValue in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            viewModel.birthday = dateFormatter.string(from: newValue)
                        }
                    Picker("Gender", selection: $gender) {
                        Text("Female").tag(Gender.female.rawValue)
                        Text("Male").tag(Gender.male.rawValue)
                        Text("N/A").tag(Gender.other.rawValue)
                    }.onChange(of: gender, perform: { value in
                        viewModel.gender = value.rawValue
                    })
                    HStack {
                        Text("Weight (kg)")
                        Spacer().frame(width: 20)
                        TextField("\(currentClientInfo.weight)", text: $viewModel.weight)
                    }
                    HStack {
                        Text("Height (m)")
                        Spacer().frame(width: 20)
                        TextField("\(currentClientInfo.height)", text: $viewModel.height)
                    }
                    Picker("Exercise preference", selection: $preference) {
                        Text("HIIT").tag(1)
                        Text("Dance").tag(2)
                        Text("Cycling").tag(3)
                    }.pickerStyle(.wheel)
                }
                Button {
                    presentationMode.wrappedValue.dismiss()
                    let clientInfo = ClientService.UpdateClientInfo(
                        client_name: viewModel.name,
                        birthday: viewModel.birthday,
                        gender: viewModel.gender,
                        height: viewModel.height,
                        weight: viewModel.weight,
                        exercisePreference: viewModel.exercisePreference
                    )
                    viewModel.updateClientInfo(updateClientInfo: clientInfo)
                } label : {
                    Text("UPDATE").font(.system(size: 23))
                }.padding()
            }.ignoresSafeArea(.keyboard)
        }
    }
}

struct ClientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ClientInfoView()
    }
}
