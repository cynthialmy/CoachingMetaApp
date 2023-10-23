//
//  CoachFinishedPlanView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/26/23.
//

import SwiftUI

struct ClientFinishedPlanView: View {
    @State var clientName: String = "Sicilia Li"
    @State var date: String = Date().toString()
    var body: some View {
        VStack (spacing: 50){
            Spacer()
            VStack (alignment: .center){
                Text("\(clientName) ").font(.system(size: 34)).bold()
                Text("Assign date: \(date)").font(.system(size: 18))
            }.foregroundColor(deepBlue)
            
            VStack (spacing: 20){
                HStack (spacing: 20){
                    HealthDataDisplayPanel(image: "map", data: 4, count: "KM")
                    HealthDataDisplayPanel(image: "heart", data: 108, count: "BPM")
                }
                HStack(spacing: 20){
                    HealthDataDisplayPanel(image: "figure.run", data: 654, count: "KCal")
                    HealthDataDisplayPanel(image: "timer", data: 86, count: "Min")
                }
                
            }
            
            ListView()
            .font(.title3)
            .padding(.horizontal, 40)
          
            Button{
                //TODO: add actions of adding plans
            } label:{
//                Text("Submit")
                Text("Edit Comments")
                    .font(.system(size: 20)).bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 60)
                    .background(Color(hex: 0xfcbf49))
                    .cornerRadius(15.0)
                
            }
            Spacer()
        }//.background(.gray.opacity(0.1))
    }
    
    @ViewBuilder
    func HealthDataDisplayPanel(image: String, data: Int, count: String) -> some View {
        VStack (spacing: 8){
            Image(systemName: image)
                
            
            Text(String(data)).font(.title).bold()
            
            Text(count)
        }
        .foregroundColor(Color(hex: 0x003049))
        .frame(width: 110, height: 120)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15).foregroundColor(Color(hex: 0xeae2b7, opacity: 0.2))
        )
        .shadow(color: Color(hex: 0xeae2b7, opacity: 0.5), radius: 5, x: 8, y: 8)
        .shadow(color: Color.white.opacity(0.5), radius: 5, x:-8, y: -8)
        
    }
}

struct CoachFinishedPlanView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClientFinishedPlanView()
        }
    }
}
