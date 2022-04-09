//
//  ContentView.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/6/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    private var healthStore: HealthStore?
    init() {
        healthStore = HealthStore()
    }
    
    // To store rate data, this goes to VM if using MVVM
//    @State private var steps: [Step] = [Step]()
    @State private var counts: [RespiratoryRate] = [RespiratoryRate]()
    
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        // .enumerationStatistics(from:, to:), .sources(), .statistics(), statistics(for: ).
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in

            // Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Attempt to convert incompatible units: count/s, count'
            //let count = statistics.averageQuantity()?.doubleValue(for: .count())
           let count = statistics.averageQuantity()?.doubleValue(for: HKUnit(from: "count/min"))
            
            // let value = quantity.doubleValue(for: HKUnit(from: "count/min"))
            let respiratery = RespiratoryRate(count: Int(count ?? 0), date: statistics.startDate)
            counts.append(respiratery)

        }
        

        print(counts)
    }
    
    var body: some View {
        List(counts, id: \.id) { i in
            Text("\(i.count)")
            Text(i.date, style: .date)
                .opacity(0.5)
            
            
        }
        
        // Display Authorization Request
            .onAppear() {
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { (success) in
                        
                        if success {
                            healthStore.calculateStep { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    // update the UI
                                    updateUIFromStatistics(statisticsCollection)
                                }
                            }
                        }
                    }
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
