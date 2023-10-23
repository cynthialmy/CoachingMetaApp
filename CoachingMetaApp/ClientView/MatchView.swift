//
//  MatchView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/26/23.
//

import SwiftUI

struct MatchView: View {
    @State var matchQueries: [MatchQuery] = [
        MatchQuery(question: "What is your exercise preference?",optionList: ["Swimming", "Cycling", "Dance", "Hiking", "Boxing"]),
        MatchQuery(question: "What is your primary fitness goal?", optionList: ["Lose weight","Build muscle", "Improve flexibility", "Increase endurance"]),
        MatchQuery(question: "What is your preferred workout environment?",
                   optionList: ["Gym", "Outdoors", "Home"]),
        MatchQuery(question: "What is your current fitness level?",
                   optionList: ["Beginner", "Intermediate", "Advanced"]),
        MatchQuery(question: "How frequently do you want to work with a coach?",
                   optionList: ["Once a week", "Twice a week", "Three times a week", "Four times a week", "More than four times a week"]),
        MatchQuery(question: "Do you have any injuries or medical conditions that may affect your workout?",
                   optionList: ["Yes", "No"]),
        MatchQuery(question: "Do you have a preferred gender of your coach?",
                   optionList: ["Must be female", "Must be male", "No"])
    ]
    @State var userAnswers: [Int] = []
    var body: some View {
        MatchQueryView(matchQueries: matchQueries, index: 0, answers: userAnswers)
    }
}

struct MatchQuery : Hashable {
    static func == (lhs: MatchQuery, rhs: MatchQuery) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(question)
    }
    @State var id = UUID()
    @State var question: String
    @State var optionList: [String]
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchView()
        }.navigationBarBackButtonHidden(true)
    }
}
