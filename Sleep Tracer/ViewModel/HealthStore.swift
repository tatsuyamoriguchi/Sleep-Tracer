//
//  HealthStore.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/7/22.
//

import Foundation
import HealthKit

// Custom class responsible for any operations related to HKHealthStore
// A wrapper around CKHealthStore
class HealthStore {
    // Instance for reading, writing health data
    var healthStore: HKHealthStore?
    
    var query: HKStatisticsCollectionQuery?
    
    // Initialize healthStore every time creating
    init() {
        // check if it is available or  not
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    // HKStatisticsCollection: Can store daily average rate and access to it
    func calculateRates(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
        // HKSampleTypes to access multiple data taypes
        
        // Define what type of data you're collecting
        let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!
        
        // Date to start Weekly respiratory data
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let anchordate = Date.mondayAt12AM()
        let hourly = DateComponents(hour: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options:  .discreteAverage, anchorDate: anchordate, intervalComponents: hourly)
        
        // Create and fire a call back handler, initialResultsHandler everytime executing a query
        query!.initialResultsHandler = { query, HKStatisticsCollection, error in
            completion(HKStatisticsCollection)
        }
        
        // Execute the query that you just created
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
        
        
        
    }
    
    
    // Authorization Request
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        // use "toShare:" to write data, but this app doesn't write data to HealthKit, so leave with an empty array, []
        healthStore.requestAuthorization(toShare: [], read: [quantityType]) { (success, error) in
            completion(success)
        }
        
        
    }
        
    
}


extension Date {
    // Week starts at 0:00 AM on Monday
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    
    func beginningOfDay() -> Date {
            let beginningOfDay = Calendar.current.startOfDay(for: self)
            return beginningOfDay
        }
}

