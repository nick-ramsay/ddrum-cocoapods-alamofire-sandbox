//
//  AppDelegate.swift
//  RememberTheAlamo
//
//  Created by Nick Ramsay on 10/7/2024.
//

import UIKit
import DatadogCore
import DatadogTrace
import DatadogRUM
import DatadogInternal
import DatadogAlamofireExtension
import Alamofire

let alamofireSession = Session(
    interceptor: DDRequestInterceptor(),
    eventMonitors: [DDEventMonitor()]
)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let appID = "5b6ef361-f81a-4220-8cf3-2e07f9946fe8"
        let clientToken = "pubbf0cffa3634c8a1669f6d592ede0b0ab"
        let environment = "staging"

        Datadog.initialize(
            with: Datadog.Configuration(
                clientToken: clientToken,
                env: environment,
                site: .us1
            ),
            trackingConsent: .granted
        )

        RUM.enable(
            with: RUM.Configuration(
                applicationID: appID,
                uiKitViewsPredicate: DefaultUIKitRUMViewsPredicate(),
                uiKitActionsPredicate: DefaultUIKitRUMActionsPredicate(),
                //urlSessionTracking: RUM.Configuration.URLSessionTracking(),
                urlSessionTracking: .init(firstPartyHostsTracing: .trace(hosts: ["dummyjson.com/users"], sampleRate: 100))
            )
        )
        
        URLSessionInstrumentation.enable(
            with: .init(
                delegateClass: SessionDelegate.self
            )
        )

        Trace.enable(
            with: Trace.Configuration(
            networkInfoEnabled: true
            )
        )

        let tracer = Tracer.shared()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

