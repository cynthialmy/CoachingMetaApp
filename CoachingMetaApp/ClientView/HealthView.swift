//
//  HealthView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/13/23.
//

import SwiftUI
import CoreGraphics
import HealthKit



struct HealthView: View {
    // these numbers can be obtained via WactchOS
    private var healthStore: HealthStore?
    @State private var steps: Int = 0
    @State private var distance: Int = 0
    @State private var calories: Int = 0
    @State private var timeSpent: Int = 0
    init() {
        healthStore = HealthStore()
    }
    
    private func updateSteps(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            steps = Int(count ?? 0)
        }
    }
    
    private func updateCalories(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0
            calories = Int(count)
        }
    }
    
    private func updateDistance(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .meter()) ?? 0
            distance = Int(count/1000)
        }
    }
   
    private func updateTimeSpent(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .minute()) ?? 0
            timeSpent = Int(count)
        }
    }
    
//    @State var userName: String = "Sicilia"
    var body: some View {
    
        VStack {
            Divider()
            HStack(alignment: .center, spacing: 100) {
                Text("Good morning,\n\(currentClientInfo.client_name).")
                    .onAppear{
                        if let healthStore = healthStore {
                            healthStore.requestAuthorization { success in
                                if success {
                                    healthStore.calculateSteps{ statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            updateSteps(statisticCollection)
                                        }
                                        
                                    }
                                    healthStore.calculateCalories{ statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            updateCalories(statisticCollection)
                                        }
                                    healthStore.calculuateDistance{ statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            updateDistance(statisticCollection)
                                        }
                                        
                                    }
                                    healthStore.calculuateExerciseTime{statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            updateTimeSpent(statisticCollection)
                                        }
                                        
                                    }
                                        
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    .bold()
                    .font(.system(size: 25))
                //                Spacer()
                Image(systemName: "cloud.sun.rain")
                    .font(.system(size: 35))
                //                Spacer()
                
            }.padding()
            
            Dial(goal: 10_000, steps:  steps)
                .padding()
           
            HStack (spacing: 20){
                VStack (spacing: 8){
                    Image(systemName: "map")
//                    Text(String(format: "%.2f", distance)).font(.title).bold()
                    Text("\(distance)").font(.title).bold()
                    Text("KM")
                }
                .frame(width: 60, height: 100)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15).foregroundColor(Color.gray).opacity(0.15)
                )
                .shadow(color: .gray, radius: 5, x: 3, y: 3)
                .shadow(color: .white, radius: 5, x: 3, y: 3)
                VStack (spacing: 8){
                    Image(systemName: "figure.run")
                    Text("\(calories)").font(.title).bold()
                    Text("KCal")
                }
                .frame(width: 60, height: 100)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15).foregroundColor(Color.gray).opacity(0.15)
                )
                .shadow(color: .gray, radius: 5, x: 3, y: 3)
                .shadow(color: .white, radius: 5, x: 3, y: 3)
                ///
                VStack (spacing: 8){
                    Image(systemName: "timer")
                    Text("\(timeSpent)").font(.title).bold()
                    Text("Min")
                }
                .frame(width: 60, height: 100)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15).foregroundColor(Color.gray).opacity(0.15)
                )
                .shadow(color: .gray, radius: 5, x: 3, y: 3)
                .shadow(color: .white, radius: 5, x: 3, y: 3)
            }
            Spacer()
            Spacer()
            Divider()
            
        }
        .foregroundColor(Color(hex: 0x003049))
        .background(Color(UIColor.gray.withAlphaComponent(0.1)))
//        .padding()
    }
}

struct Dial: View {
    let goal: Int
    let steps: Int
    
    var body: some View {
        
        ZStack {
            Circle().stroke(style: StrokeStyle(lineWidth: 10,
                                               dash: [2, 30], dashPhase: 10)).opacity(0.2)
            Circle().fill(Color.white)
                                .shadow(color: .gray, radius: 9, x: 8, y: 8)
                                .shadow(color: .white, radius: 9, x: 8, y: 8).padding(20)
    
            ZStack {
                Circle().fill(Color.gray).opacity(0.1)
                    .shadow(color: .gray, radius: 9, x: 8, y: 8)
                    .shadow(color: .white, radius: 9, x: 8, y: 8)

                Circle().stroke(style: StrokeStyle(lineWidth: 12))
                    .padding(50)
                    .foregroundColor(Color.gray).opacity(0.6)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(steps) / CGFloat(goal))
                    .rotation(.degrees(-90))
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, dash:[5,3]))
                    .padding(50)
                
                
                VStack (spacing: 15){
                    Text("Goal: \(goal)")
                    Text("\(steps)")
                        .bold()
                        .font(.system(size: 50))
                    Text("steps")
                }
            }
            
        }
        
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
//        BaseView()
    }
}
