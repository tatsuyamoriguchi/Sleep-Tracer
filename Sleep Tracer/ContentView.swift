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
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        // .enumerationStatistics(from:, to:), .sources(), .statistics(), statistics(for: ).
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            let minRate = statistics.minimumQuantity()?.doubleValue(for: .count())
            let rate = RespiratoryRate(rate: Int(minRate ?? 0), date: statistics.startDate)
            
        }

    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
        
        // Display Authorization Request
            .onAppear() {
                if let healthStore = healthStore {
                    healthStore.requestAuthrization { (success) in
                        
                        if success {
                            healthStore.calculateRespiratoryRate { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    // update the UI
                                    print(statisticsCollection)
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
