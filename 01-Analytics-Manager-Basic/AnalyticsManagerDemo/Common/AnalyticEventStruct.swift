//
//  AnalyticEventStruct.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

import Foundation

struct AnalyticEventStruct: AnalyticsEvent {
    var name: String
    var time: Date
    var properties: [String: Any]?
}
