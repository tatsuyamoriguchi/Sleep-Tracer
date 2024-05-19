//
//  RespiratoryRate.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/6/22.
//

import SwiftUI
import HealthKit

struct RespiratoryRate: View {
    
    private var healthStore: HealthStore?
    init() {
        healthStore = HealthStore()
    }
    
    @State private var counts: [RespiratoryRate] = [RespiratoryRate]()
    
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        // Clear the counts array to prevent duplicates
        counts.removeAll()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in

           let count = statistics.averageQuantity()?.doubleValue(for: HKUnit(from: "count/min"))
            
            let respiratory = RespiratoryRate(count: Int(count ?? 0), date: statistics.startDate)
            counts.append(respiratory)
        }
        
        counts = counts.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        NavigationView {
            
            List(counts, id: \.id) { i in
               
                Text(i.date, style: .date)
                    .opacity(0.5)
                Text(i.date, style: .time)
                    .opacity(0.5)

                // Change font color based on value.
                switch i.count {
                case 0:
                    Text("")
                case 1..<10:
                    // too low rate
                    Text("\(i.count)").foregroundColor(.blue)
                case 10..<20:
                    Text("\(i.count)")
                case 20...:
                    // too high rate
                    Text("\(i.count)").foregroundColor(.red)
                default:
                    Text("")
                }
            }
            .refreshable(action: {
                getData()
            })
            .toolbar {
                ToolbarItem {
                    Text("Respiratory Rates")
                        .font(.custom("Inter-ExtraLight", size: 34))
                        .foregroundColor(.cyan)
                }
            }

            .toolbarBackground(.visible, for: .navigationBar)            // The color scheme will apply only when the background is shown.
            .toolbarBackground(Color.black, for: .navigationBar) // Specify the color of the toolbar background.
            .toolbarColorScheme(.dark, for: .navigationBar) // By specifying the corlor scheme to dark, the font color changes to white.
            .scrollContentBackground(.hidden) // To change the List view background color, hide the scrollContentBackgroudn first.
            .background(.black) // Then change the background color
        }
        // Display Authorization Request
        .onAppear() {
            getData()
        }

    }
    
    func getData() {
        // Unwrap healthStore
        if let healthStore = healthStore {
            // Request authorization
            healthStore.requestAuthorization { (success) in
                // if requestAuthorization is success,
                if success {
                    // Calculate
                    print("Authorization success")
                    healthStore.calculateRates { statisticsCollection in
                        if let statisticsCollection = statisticsCollection {
                            // update the UI
                            updateUIFromStatistics(statisticsCollection)

                        }
                    }
                } else {
                    print("Authorization failed.")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RespiratoryRate()
    }
}
