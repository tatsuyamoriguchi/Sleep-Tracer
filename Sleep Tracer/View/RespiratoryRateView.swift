//
//  RespiratoryRateListView.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 5/28/24.
//

import SwiftUI


enum DisplayType: Int, Identifiable, CaseIterable {
    case list
    case chart
    
    var id: Int {
        rawValue
    }
}

extension DisplayType {
    var icon: String {
        switch self {
        case .list:
            return "list.bullet"
        case .chart:
            return "chart.bar"
        }
    }
}

struct RespiratoryRateView: View {
    @State private var displayType: DisplayType = .list
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Selection", selection: $displayType) {
                    ForEach(DisplayType.allCases) { displayType in
                        Image(systemName: displayType.icon)
                            .tag(displayType)
                    }
                }
                .pickerStyle(.segmented)
                .background(Color.gray)
                .padding()
                
                RespiratoryRateListView()
                
            }
            
            .navigationTitle("")
            .toolbar {
                ToolbarItem {
                    Text("Respiratory Rates")
                        .font(.custom("Inter-ExtraLight", size: 36))
                        .foregroundColor(.cyan)
                }
            }
            .toolbarBackground(.black, for: .navigationBar)
            .background(Color.black)
        }
    }

}

#Preview {
        RespiratoryRateView()
}
