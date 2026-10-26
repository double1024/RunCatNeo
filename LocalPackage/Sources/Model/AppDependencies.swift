/*
 AppDependencies.swift
 Model

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import SwiftUI

public struct AppDependencies: Sendable {
    public var appStateClient = AppStateClient.liveValue
    public var dataClient = DataClient.liveValue
    public var dateClient = DateClient.liveValue
    public var fileManagerClient = FileManagerClient.liveValue
    public var fileWatcherClient = FileWatcherClient.liveValue
    public var loggingSystemClient = LoggingSystemClient.liveValue
    public var nsAppClient = NSAppClient.liveValue
    public var nsWorkspaceClient = NSWorkspaceClient.liveValue
    public var smAppServiceClient = SMAppServiceClient.liveValue
    public var systemInfoObserverClient = SystemInfoObserverClient.liveValue
    public var urlClient = URLClient.liveValue
    public var userDefaultsClient = UserDefaultsClient.liveValue
    public var uuidClient = UUIDClient.liveValue

    static let shared = AppDependencies()
}

extension EnvironmentValues {
    @Entry public var appDependencies = AppDependencies.shared
}

extension AppDependencies {
    public static func testDependencies(
        appStateClient: AppStateClient = .testValue,
        dataClient: DataClient = .testValue,
        dateClient: DateClient = .testValue,
        fileManagerClient: FileManagerClient = .testValue,
        fileWatcherClient: FileWatcherClient = .testValue,
        loggingSystemClient: LoggingSystemClient = .testValue,
        nsAppClient: NSAppClient = .testValue,
        nsWorkspaceClient: NSWorkspaceClient = .testValue,
        smAppServiceClient: SMAppServiceClient = .testValue,
        systemInfoObserverClient: SystemInfoObserverClient = .testValue,
        urlClient: URLClient = .testValue,
        userDefaultsClient: UserDefaultsClient = .testValue,
        uuidClient: UUIDClient = .testValue
    ) -> AppDependencies {
        AppDependencies(
            appStateClient: appStateClient,
            dataClient: dataClient,
            dateClient: dateClient,
            fileManagerClient: fileManagerClient,
            fileWatcherClient: fileWatcherClient,
            loggingSystemClient: loggingSystemClient,
            nsAppClient: nsAppClient,
            nsWorkspaceClient: nsWorkspaceClient,
            smAppServiceClient: smAppServiceClient,
            systemInfoObserverClient: systemInfoObserverClient,
            urlClient: urlClient,
            userDefaultsClient: userDefaultsClient,
            uuidClient: uuidClient
        )
    }
}
