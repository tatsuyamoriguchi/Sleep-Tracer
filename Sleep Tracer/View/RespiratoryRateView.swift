//
//  RespiratoryRateListView.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 5/28/24.
//

import SwiftUI

struct RespiratoryRateListView: View {
    var counts: [RespiratoryRateData]
    
    var body: some View {
        List(counts) { rate in
            HStack {
                Text("\(rate.date) - \(rate.count)")
            }
            
        }
    }
}

#Preview {
    RespiratoryRateListView(counts: [])
}
