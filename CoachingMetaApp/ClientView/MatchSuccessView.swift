//
//  MatchSuccessView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/26/23.
//

import SwiftUI

struct MatchSuccessView: View {
    @State var isLoading: Bool = true
    private var systemService = SystemService()
    private var coach_id: String = "coach_testing"
    private func updateMatchCoachAndNavigate(client_id: String, coach_id: String) {
        systemService.updateMatchInfo(client_id: client_id, coach_id: coach_id) { result in
            
        }
    }
    var body: some View {
        VStack (spacing: 50){
            if isLoading {
                LoadingDots()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                            updateMatchCoachAndNavigate(client_id: userID, coach_id: coach_id)
                                                    }
                    }
            }
            
            
            else {
                Text("Match Success!").foregroundColor(orange).bold().font(.system(size: 50))

                
                VStack{
                    Image("coac-icon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(orange, lineWidth: 2))
                    Text("Coach Name").foregroundColor(deepBlue).bold()
                }
                
                
                NavigationLink(destination: BaseView().navigationBarBackButtonHidden(true)) {
                    Text("LET'S TALK!")
                        .foregroundColor(Color.white)
                        .bold()
                        .font(.system(size: 30))
                        .frame(width: 200, height: 60)
                        .background(yellow)
                        .cornerRadius(20)
                        .shadow(color: .gray, radius: 5, x: 3, y: 3)
                        .shadow(color: .white, radius: 5, x: 3, y: 3)
                    
                }
            }
            }

    }
}

struct MatchSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchSuccessView()
        }
    }
}
