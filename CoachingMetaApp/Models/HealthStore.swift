//
//  HealthStore.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/13/23.
//

import Foundation
import HealthKit

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class HealthStore {
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let startDate = Calendar.current.date(byAdding: .day, value : -1, to: Date()) // calculate the steps in the last day
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
        
    }
    
    func calculateCalories(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let caloryType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let startDate = Calendar.current.date(byAdding: .day, value : -1, to: Date()) // calculate the steps in the last day
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: caloryType, quantitySamplePredicate: predicate, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
    func calculuateDistance(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let distanceType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        let startDate = Calendar.current.date(byAdding: .day, value : -1, to: Date()) // calculate the steps in the last day
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: distanceType, quantitySamplePredicate: predicate, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
    func calculuateExerciseTime(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let exerciseTimeType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!
        let startDate = Calendar.current.date(byAdding: .day, value : -1, to: Date()) // calculate the steps in the last day
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: exerciseTimeType, quantitySamplePredicate: predicate, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
//    
//    func calculuateHeartRate(completion: @escaping (HKStatisticsCollection?) -> Void) {
//        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
//        let now = Date()
//        let startOfDay = Calendar.current.startOfDay(for: now)
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
//        let anchorDate = Date.mondayAt12AM()
//        
//        
//        
//        query!.initialResultsHandler = { query, statisticsCollection, error in
//            completion(statisticsCollection)
//        }
//        
//        
//        if let healthStore = healthStore, let query = self.query {
//            healthStore.execute(query)
//        }
//    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier:
                HKQuantityTypeIdentifier.stepCount)! // access step data
        let energyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let distanceType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        let timeType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!
        let heartRateType = HKQuantityType.quantityType(forIdentifier:
                                                            HKQuantityTypeIdentifier.heartRate)!
        
        guard let healthStore = self.healthStore else {return completion(false )}
//        let caloryType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.)
        
        healthStore.requestAuthorization(toShare: [], read: [stepType, energyType, distanceType, timeType, heartRateType]) { (success, error) in
            completion(success)
        }
    }
}
