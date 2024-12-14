//
//  ContentViewEvent.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

import Foundation

enum ContentViewEvent {
    static func viewAppeared(_ id: String) -> AnalyticEventStruct {
        AnalyticEventStruct(name: "Appeared", time: Date(), properties: ["id": id])
    }

    static func viewDisappeared(_ id: String) -> AnalyticEventStruct {
        AnalyticEventStruct(name: "Disappeared", time: Date(), properties: ["id": id])
    }

    static func buttonTapped(_ id: String) -> AnalyticEventStruct {
        AnalyticEventStruct(name: "Tapped", time: Date(), properties: ["id": id])
    }
}
