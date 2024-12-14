//
//  ConsoleAnalyticsService.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

final class ConsoleAnalyticsService: AnalyticsService {
    var label: String = "ConsoleAnalyticsService"

    var userId: String?
    var sessionId: String?
    var properties: [String: Any] = [:]
    var isTrackingEnabled: Bool = true

    init() {}

    func trackEvent(_ event: AnalyticsEvent) {
        guard isTrackingEnabled, shouldTrackEvent(event) else { return }
        print("Event: \(event), userId: \(userId ?? "nil"), sessionId: \(sessionId ?? "nil"), userProperties: \(properties)")
    }

    func shouldTrackEvent(_: AnalyticsEvent) -> Bool { true }
}
