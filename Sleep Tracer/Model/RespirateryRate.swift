//
//  RespirateryRate.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/7/22.
//

import Foundation


struct RespiratoryRate: Identifiable, Hashable {
    let id = UUID()
    let count: Int
    let date: Date
    
}
