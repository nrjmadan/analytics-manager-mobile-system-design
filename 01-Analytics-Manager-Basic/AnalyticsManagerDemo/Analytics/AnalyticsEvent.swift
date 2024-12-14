//
//  AnalyticsEvent.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

import Foundation

protocol AnalyticsEvent {
    var name: String { get }
    var time: Date { get }
    var properties: [String: Any]? { get }
}
