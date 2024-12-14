//
//  AnalyticsManagerDemoApp.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

import SwiftUI

@main
struct AnalyticsManagerDemoApp: App {
    @StateObject private var analyticsManager = {
        let manager = AnalyticsManager.shared
        manager.addService(ConsoleAnalyticsService())
        return manager
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(analyticsManager)
        }
    }
}
