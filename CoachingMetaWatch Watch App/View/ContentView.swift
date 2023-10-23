//
//  ContentView.swift
//  watchApp Watch App
//
//  Created by Sicilia Li on 4/25/23.
//

import SwiftUI
import CoreGraphics
import HealthKit

var deepBlue = Color(hex: 0x003049)
var orange = Color(hex: 0xf77f00)
var yellow = Color(hex: 0xfcbf49)

struct ContentView: View {
    @State private var steps: Int = 9633
    @State private var distance: Int = 5
    @State private var calories: Int = 135
    @State private var timeSpent: Int = 35
    @State private var heartRate: Int = 75
    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateCalories(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0
            
            calories = Int(count)
        }
    }
    
    private func updateTimeSpent(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .minute()) ?? 0
            timeSpent = Int(count) //
            print("timeSpent" + String(timeSpent))
        }
    }
    
    private func updateDistance(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .meter()) ?? 0
            distance = Int(count/1000) // count / 1000
            print("distance: " + String(distance))
            
        }
    }
    
    private func updateHeartRate(_ statisticsCollection: HKStatisticsCollection) {
        let statistics = statisticsCollection.statistics()
        guard let mostRecentQuantity = statistics.first?.averageQuantity() else {
            print("No heart rate data available")
            return
        }
        
        let count = mostRecentQuantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
        heartRate = Int(count)
        print("current rate: " + String(heartRate))
    }
    
    var body: some View {
        
        NavigationView {
            
            List {
                Text("Good Morning!").bold()
                    .onAppear{
                        if let healthStore = healthStore {
                            healthStore.requestAuthorization { success in
                                if success {
                                    healthStore.calculuateExerciseTime { statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            updateTimeSpent(statisticCollection)
                                        }
                                    }
                                    healthStore.calculateCalories { statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            updateCalories(statisticCollection)
                                        }
                                    }
                                    healthStore.calculuateDistance { statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            updateDistance(statisticCollection)
                                        }
                                    }
                                    healthStore.calculateHeartRate { statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            updateHeartRate(statisticCollection)
                                        }

                                    }
                                }
                                
                            }
                        }
                    }

                VStack (alignment: .center) {
                    HStack (alignment: .firstTextBaseline){
                        Image(systemName: "timer")
                            .font(.system(size: 26))
        //                Spacer()
                        Text("Walk Time").font(.system(size: 16))
                    }
                    Text("\(timeSpent)").font(.system(size: 46))
                    Text("Min").font(.system(size: 13)).foregroundColor(yellow)
                }.padding()
                
                VStack (alignment: .center) {
                    HStack (alignment: .firstTextBaseline){
                        Image(systemName: "figure.run")
                            .font(.system(size: 26))
        //                Spacer()
                        Text("Calories").font(.system(size: 16))
                    }
                    Text("\(calories)").font(.system(size: 46))
                    Text("KCal").font(.system(size: 13)).foregroundColor(yellow)
                }.padding()
                
                VStack (alignment: .center) {
                    HStack (alignment: .firstTextBaseline){
                        Image(systemName: "heart.circle")
                            .font(.system(size: 26))
        //                Spacer()
                        Text("Heart Rate").font(.system(size: 16))
                    }
                    Text("\(heartRate)").font(.system(size: 46))
                    Text("BPM").font(.system(size: 13)).foregroundColor(yellow)
                }.padding()
                
                VStack (alignment: .center) {
                    HStack (alignment: .firstTextBaseline){
                        Image(systemName: "map")
                            .font(.system(size: 26))
        //                Spacer()
                        Text("Distance").font(.system(size: 16))
                    }
                    Text("\(distance)").font(.system(size: 46))
                    Text("KM").font(.system(size: 13)).foregroundColor(yellow)
                }.padding()
                
//                HealthDataRowView(ImageName: "timer", TextString: "Walk Time", Number: timeSpent, Description: "Min")
//                HealthDataRowView(ImageName: "figure.run", TextString: "Calories", Number: calories, Description: "KCal")
//                HealthDataRowView(ImageName: "heart.circle", TextString: "Heart Rate", Number: heartRate, Description: "BPM")
//                HealthDataRowView(ImageName: "map", TextString: "Distance", Number: distance, Description: "KM")
                
                NavigationLink(destination: WatchAddPlanView()) {
                    Text(" Add new Workout")
                    
                }.listStyle(PlainListStyle())
                
            }.padding(.horizontal)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }
    }
}
