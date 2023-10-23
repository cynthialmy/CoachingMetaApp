//
//  MatchQueryView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/26/23.
//

import SwiftUI

struct MatchQueryView: View {
//    @State var newMessage: String = "What is your exercise preference?"
//    @State var optionList: [String] = [
//    "Swimming", "Cycling", "Dance", "Hiking", "Boxing"
//    ]
    @State var matchQueries: [MatchQuery] = []
    @State var index: Int = 0
    @State var length: Int = 0
    @State var answers: [Int] = []
    @State var pressedStart: Bool = false
    var body: some View {
        let newMessage: String = matchQueries[index].question
        let optionList: [String] = matchQueries[index].optionList
        if (!pressedStart) {
            VStack (alignment: .center, spacing: 60){
               
                VStack (spacing: 20){
                    Image(systemName: "person.2.slash")
                        .font(.system(size: 35))
                        .bold()
                    Text("You don't have a coach yet.")
                       .font(.system(size: 25))
                       .bold()
                }
               
                Button {
                    pressedStart = true
                } label: {
                    Text("Let's match!")
                        .foregroundColor(Color.white)
                        
                        .frame(width: 150, height: 50)
                        .background(yellow)
                        .cornerRadius(15)
                }
           }.padding()
        }
        else{
        VStack (spacing: 50){
            HStack (alignment: .firstTextBaseline){
                Image("robot-icon")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(newMessage)
                    .padding()
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(Color.white)
                    .background(Color(hex: 0xfcbf49))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                    .shadow(color: .gray, radius: 5, x: 3, y: 3)
                    .shadow(color: .white, radius: 5, x: 3, y: 3)
            }
            
            VStack (spacing: 20){
                ForEach(Array(optionList.enumerated()), id:\.1) { index, option in
                    NavigationLink {
                        if (self.index == matchQueries.count - 1) {
//                            MatchSuccessView()
//                            LoadingDots()
                            MatchSuccessView()
                        }
                        else {
    
                            MatchQueryView(matchQueries: matchQueries,
                                           index: self.index + 1,
                                           answers: answers, pressedStart: true)
                        }
                        
                    } label: {
                        QuizOptionView(quizOption: option, seq: index + 1)
                        
                    }.foregroundColor(Color.white)
                    }
            }
            
          
        }.padding()}
    }
    
    
}

struct QuizOptionView: View {
    @State var quizOption: String
    @State var seq: Int

    func alphabetNumber(_ number: Int) -> String? {
        if let scalar = UnicodeScalar(64 + number) {
            return String(scalar)
        }
        return nil
    }

    var body: some View {
        HStack{
            ZStack {
                Circle()
                    .fill(orange)
                    .frame(width:25, height: 25)
                Text(String(alphabetNumber(seq) ?? "A") )
                    .foregroundColor(Color.white).bold()
            }.offset(x:10)
            HStack {
            
            Text("     \(quizOption)")
                .foregroundColor(Color.black)
                .bold()
                .font(.system(size: 20))
            Spacer()
            }.frame(width: 300, height: 60)
        }
        .padding()
        .frame(width: 330, height: 50)
        .background(deepBlue.opacity(0.1))
        .cornerRadius(45)
            
        
    }
}


struct MatchQueryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchView()
        }.navigationBarBackButtonHidden(true)
        
    }
}
