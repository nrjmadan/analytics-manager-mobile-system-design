//
//  ContentView.swift
//  AnalyticsManagerDemo
//
//  Created by Neeraj Madan on 13/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var analyticsManager: AnalyticsManager
    @State private var viewTrackingId: String = UUID().uuidString
    var buttonTrackingId: String { "\(viewTrackingId)/button" }
    var analytics: AnalyticsService { analyticsManager }

    var body: some View {
        VStack(spacing: 20) {
            button()
            goToNextLink()
        }
        .onAppear(perform: appearAction)
        .onDisappear(perform: disappearAction)
    }

    func button() -> some View {
        Button("Tap Me", action: buttonAction)
        .buttonStyle(.borderedProminent)
    }

    func goToNextLink() -> some View {
        NavigationLink("Go To Next", destination: ContentView())
    }

    func buttonAction() {
        analytics.trackEvent(ContentViewEvent.buttonTapped(buttonTrackingId))
    }

    func appearAction() {
        analytics.trackEvent(ContentViewEvent.viewAppeared(viewTrackingId))
    }

    func disappearAction() {
        analytics.trackEvent(ContentViewEvent.viewDisappeared(viewTrackingId))
    }
}

#Preview {
    @Previewable @StateObject var analyticsManager: AnalyticsManager = PreviewAnalyticsManager().service
    NavigationStack {
        ContentView()
    }
    .environmentObject(analyticsManager)
}
