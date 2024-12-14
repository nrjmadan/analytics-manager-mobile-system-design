//
//  MockAnalyticsService.swift
//  AnalyticsManagerDemoTests
//
//  Created by Neeraj Madan on 14/12/24.
//

@testable import AnalyticsManagerDemo
import Foundation

final class MockAnalyticsService: AnalyticsService {
    var label: String = "MockAnalyticsService"

    var userId: String?
    var sessionId: String?
    var properties: [String: Any]
    var isTrackingEnabled: Bool

    var shouldTrackEvents: Bool = true
    var recordedEvents: [AnalyticsManagerDemo.AnalyticsEvent] = []

    init(
        label: String,
        userId: String? = nil,
        sessionId: String? = nil,
        properties: [String: Any] = [:],
        isTrackingEnabled: Bool = true,
        shouldTrackEvents: Bool = true
    ) {
        self.label = label
        self.userId = userId
        self.sessionId = sessionId
        self.properties = properties
        self.isTrackingEnabled = isTrackingEnabled
        self.shouldTrackEvents = shouldTrackEvents
    }

    func trackEvent(_ event: AnalyticsManagerDemo.AnalyticsEvent) {
        recordedEvents.append(event)
    }

    func shouldTrackEvent(_: any AnalyticsManagerDemo.AnalyticsEvent) -> Bool {
        shouldTrackEvents
    }
}
