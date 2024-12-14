//
//  AnalyticsService.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

protocol AnalyticsService: AnyObject {
    var label: String { get set }

    var userId: String? { get set }
    var sessionId: String? { get set }
    var properties: [String: Any] { get set }
    var isTrackingEnabled: Bool { get set }

    func trackEvent(_ event: AnalyticsEvent)
    func shouldTrackEvent(_ event: AnalyticsEvent) -> Bool
}
