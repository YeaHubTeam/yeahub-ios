//
//  YeaHubApp.swift
//  YeaHub
//
//  Created by Роман on 11.07.2025.
//

import SwiftUI

@main
struct YeaHubApp: App {
    @StateObject private var appCoordinator: AppCoordinatorImpl

    init() {
        let appFactory = AppFactoryImpl()
        _appCoordinator = StateObject(wrappedValue: AppCoordinatorImpl(appFactory: appFactory))
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear {
                    appCoordinator.start()
                }
        }
    }
}
