//
//  AnalyticsManager.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

import Combine

final class AnalyticsManager: AnalyticsService, ObservableObject {

    static var shared = AnalyticsManager()
    private(set) var services: [AnalyticsService] = []

    var label: String = "AnalyticsManager"

    var userId: String? {
        didSet { services.forEach { $0.userId = userId } }
    }

    var sessionId: String? {
        didSet { services.forEach { $0.sessionId = sessionId } }
    }

    var properties: [String: Any] = [:] {
        didSet { services.forEach { $0.properties = properties } }
    }

    var isTrackingEnabled: Bool = true {
        didSet { services.forEach { $0.isTrackingEnabled = isTrackingEnabled } }
    }

    func addService(_ service: AnalyticsService) {
        services.append(service)
    }

    func removeService(withLabel label: String) {
        services.removeAll { label == $0.label }
    }

    func trackEvent(_ event: AnalyticsEvent) {
        guard isTrackingEnabled else { return }

        for service in services {
            service.trackEvent(event)
        }
    }

    func shouldTrackEvent(_ event: AnalyticsEvent) -> Bool {
        services.firstIndex { $0.shouldTrackEvent(event) == true } != nil
    }
}
