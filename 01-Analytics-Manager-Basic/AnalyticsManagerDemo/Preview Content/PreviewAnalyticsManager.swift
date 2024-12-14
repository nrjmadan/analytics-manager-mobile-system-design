//
//  PreviewAnalyticsManager.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

import Combine

final class PreviewAnalyticsManager: ObservableObject {
    var service: AnalyticsManager = .shared

    init() { service.addService(ConsoleAnalyticsService()) }
}
