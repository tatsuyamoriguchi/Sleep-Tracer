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
    
    // HKStatisticsCollection
    // Can store daily average rate and access to it
    func calculateStep(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!
        
        // Date to start Weekly respiratory data
        let startDate = Calendar.current.date(bySetting: .day, value: -7, of: Date())
        let anchordate = Date.mondayAt12AM()
        //let daily = DateComponents(day: 1)
        let hourly = DateComponents(hour: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .discreteAverage, anchorDate: anchordate, intervalComponents: hourly)
        
        // Create and fire a call back handler, initialResultsHandler everytime executinga query
        query!.initialResultsHandler = { query, HKStatisticsCollection, error in
            completion(HKStatisticsCollection)
        }
        
        // Execute the query
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
        
        
        
    }
    
    
    // Authorization Request
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        // toShare to write data,
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
}
