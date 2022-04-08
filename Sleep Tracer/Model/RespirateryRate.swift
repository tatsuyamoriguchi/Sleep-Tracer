//
//  RespirateryRate.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/7/22.
//

import Foundation

struct RespiratoryRate: Identifiable {
    let id = UUID()
    let rate: Int
    let date: Date
}
