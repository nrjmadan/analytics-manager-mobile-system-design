//
//  AnalyticsManagerDemoTests.swift
//  AnalyticsManagerDemoTests
//
//  Created by Neeraj Madan on 14/12/24.
//

@testable import AnalyticsManagerDemo
import Foundation
import Testing

struct AnalyticsManagerDemoTests {

    @Test("Does not set label on services")
    func doesNotSetLabelOnServices() {
        let (sut, services) = manager(serviceCount: 2)

        sut.label = "label"
        for service in services {
            #expect(service.label != "label")
        }
    }

    @Test("Sets user id on all services")
    func setsUserIdOnAllServices() {
        let (sut, services) = manager(serviceCount: 2)

        sut.userId = "userId"
        for service in services {
            #expect(service.userId == "userId")
        }

        sut.userId = nil
        for service in services {
            #expect(service.userId == nil)
        }
    }

    @Test("Sets session id on all services")
    func setsSessionIdOnAllServices() {
        let (sut, services) = manager(serviceCount: 2)

        sut.sessionId = "sessionId"
        for service in services {
            #expect(service.sessionId == "sessionId")
        }

        sut.sessionId = nil
        for service in services {
            #expect(service.sessionId == nil)
        }
    }

    @Test("Sets properties on all services")
    func setsPropertiesOnAllServices() throws {
        let (sut, services) = manager(serviceCount: 2)

        sut.properties = ["key": "value"]
        try services.forEach {
            #expect($0.properties.count == 1)
            let value = try #require($0.properties["key"] as? String)
            #expect(value == "value")
        }

        sut.properties["key2"] = "value2"
        try services.forEach {
            #expect($0.properties.count == 2)
            let value = try #require($0.properties["key2"] as? String)
            #expect(value == "value2")
        }

        sut.properties.removeValue(forKey: "key2")
        for service in services {
            #expect(service.properties.count == 1)
            #expect(service.properties["key2"] == nil)
        }

        sut.properties = [:]
        for service in services {
            #expect(service.properties.isEmpty)
        }
    }

    @Test("Sets isTrackingEnabled on all services")
    func setsIsTrackingEnabledOnAllServices() {
        let (sut, services) = manager(serviceCount: 2)

        sut.isTrackingEnabled = false
        for service in services {
            #expect(!service.isTrackingEnabled)
        }

        sut.isTrackingEnabled = true
        for service in services {
            #expect(service.isTrackingEnabled)
        }
    }

    @Test("Does not pass event to services if tracking is disabled.")
    func doesNotPassEventToServicesIfTrackingIsDisabled() {
        let (sut, services) = manager(serviceCount: 2)
        let event = AnalyticEventStruct(name: "test", time: Date(), properties: ["key": "value"])
        sut.isTrackingEnabled = false

        sut.trackEvent(event)
        for service in services {
            #expect(service.recordedEvents.isEmpty)
        }
    }

    @Test("Passes multiple events to all services")
    func passesMultipleEventsToAllServices() throws {
        let (sut, services) = manager(serviceCount: 2)
        let firstTime = Date()
        let firstEvent = AnalyticEventStruct(name: "test", time: firstTime, properties: ["key": "value"])
        sut.isTrackingEnabled = true

        sut.trackEvent(firstEvent)
        try services.forEach {
            #expect($0.recordedEvents.count == 1)
            let firstRecorded = try #require($0.recordedEvents.first)
            #expect(firstRecorded.name == "test")
            #expect(firstRecorded.time == firstTime)
            #expect(firstRecorded.properties?.count == 1)
            let value = try #require(firstRecorded.properties?["key"] as? String)
            #expect(value == "value")
        }

        let secondTime = Date()
        let secondEvent = AnalyticEventStruct(name: "test2", time: secondTime, properties: ["key2": "value2"])
        sut.trackEvent(secondEvent)
        try services.forEach {
            #expect($0.recordedEvents.count == 2)
            let secondRecorded = try #require($0.recordedEvents[1])
            #expect(secondRecorded.name == "test2")
            #expect(secondRecorded.time == secondTime)
            #expect(secondRecorded.properties?.count == 1)
            let value = try #require(secondRecorded.properties?["key2"] as? String)
            #expect(value == "value2")
        }
    }

    @Test("ShouldTrackEvent returns false when no services are registered")
    func returnsCorrectValueForShouldTrackEvent() {
        let (sut, _) = manager(serviceCount: 0)
        let event = AnalyticEventStruct(name: "test", time: Date(), properties: ["key": "value"])

        #expect(!sut.shouldTrackEvent(event))
    }

    @Test("ShouldTrackEvent returns false if no service tracks event")
    func returnsCorrectValueForShouldTrackEventWhenNoServiceTrackEvent() throws {
        let (sut, services) = manager(serviceCount: 2)
        let event = AnalyticEventStruct(name: "test", time: Date(), properties: ["key": "value"])
        services.forEach { $0.shouldTrackEvents = false }

        #expect(!sut.shouldTrackEvent(event))
    }

    @Test("ShouldTrackEvent returns true if any service tracks event")
    func returnsCorrectValueForShouldTrackEventWhenAnyServiceTrackEvent() throws {
        let (sut, services) = manager(serviceCount: 2)
        let event = AnalyticEventStruct(name: "test", time: Date(), properties: ["key": "value"])

        services[0].shouldTrackEvents = true
        services[1].shouldTrackEvents = false
        #expect(sut.shouldTrackEvent(event))

        services[0].shouldTrackEvents = false
        services[1].shouldTrackEvents = true
        #expect(sut.shouldTrackEvent(event))

        services[0].shouldTrackEvents = true
        services[1].shouldTrackEvents = true
        #expect(sut.shouldTrackEvent(event))
    }

    @Test("Services are added")
    func servicesAreAdded() throws {
        let sut = AnalyticsManager()
        sut.addService(MockAnalyticsService(label: "test"))
        #expect(sut.services.count == 1)
        let service = try #require(sut.services.first)
        #expect(service.label == "test")
    }

    @Test("Services are removed")
    func servicesAreRemoved() throws {
        let sut = AnalyticsManager()
        sut.addService(MockAnalyticsService(label: "test"))
        sut.addService(MockAnalyticsService(label: "test2"))

        sut.removeService(withLabel: "TEST")
        #expect(sut.services.count == 2)

        sut.removeService(withLabel: "test")
        #expect(sut.services.count == 1)
        let service = try #require(sut.services[0])
        #expect(service.label == "test2")
    }

}

extension AnalyticsManagerDemoTests {

    func manager(serviceCount: Int = 1) -> (AnalyticsManagerDemo.AnalyticsManager, [MockAnalyticsService]) {
        let manager = AnalyticsManagerDemo.AnalyticsManager()
        guard serviceCount > 0 else { return (manager, []) }

        var services = [MockAnalyticsService]()
        for index in 1 ... serviceCount {
            let service = MockAnalyticsService(label: "\(index)")
            services.append(service)
            manager.addService(service)
        }

        return (manager, services)
    }

}
