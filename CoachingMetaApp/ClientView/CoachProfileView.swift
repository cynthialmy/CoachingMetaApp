//
//  CoachProfileView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/14/23.
//

import SwiftUI


// convert birthday format to age
extension String {
    func age() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: date, to: now)
        return ageComponents.year
    }
}

struct CoachProfileView: View {
    @StateObject private var viewModel = MyCoachViewModel()
    let uid: String // Provide the coach UID
    
    var body: some View {
        List {
            HStack{
                Text("Coach Name").bold()
                Spacer().frame(width: 20)
                Text(viewModel.name)
            }
            HStack {
                Text("Age").bold()
                Spacer().frame(width: 20)
                Text(viewModel.age)
            }
            HStack {
                Text("Gender").bold()
                Spacer().frame(width: 20)
                Text(viewModel.gender)
            }
            HStack {
                Text("Height").bold()
                Spacer().frame(width: 20)
                Text(viewModel.height)
            }
            HStack {
                Text("Weight").bold()
                Spacer().frame(width: 20)
                Text(viewModel.weight)
            }
            HStack {
                Text("Coaching Experience").bold()
                Spacer().frame(width: 20)
                Text(viewModel.coachingExperience)
            }
            HStack {
                Text("Specialization").bold()
                Spacer().frame(width: 20)
                Text(viewModel.specialization)
            }
        }.listStyle(PlainListStyle())
            .onAppear {
                viewModel.fetchCoachInfo(uid: uid)
            }
    }
}

struct CoachProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CoachProfileView(uid: "coach1")
    }
}
