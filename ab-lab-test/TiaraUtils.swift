//
//  TiaraUtils.swift
//  ab-lab-test
//
//  Created by jaddy on 6/4/25.
//

import Foundation
import TiaraSDK
import UIKit
private let userDefaults = UserDefaults(suiteName: "com.kakao.tiaraSDK")

func initId() {
    DispatchQueue.main.async {
        print(userDefaults?.string(forKey: "tuid") ?? "없음")
        userDefaults?.removeObject(forKey: "tuid")
        exit(0)
    }

}


func initTiaraTracker() {
    TiaraTracker.initialize(configuration: configuration)
    var instanceConfiguration = TiaraInstanceConfiguration()
    instanceConfiguration.isDebugLoggerEnabled = true
    TiaraTracker.newInstance(svcDomain: "svc.domain", configuration: instanceConfiguration)
}


var tuid: String {
    userDefaults?.string(forKey: "tuid") ?? ""
}

var configuration: TiaraGlobalConfiguration {
    var globalConfiguration = TiaraGlobalConfiguration()
    globalConfiguration.deployment = .sandbox
            globalConfiguration.sessionTimeout = 5
            globalConfiguration.cookieDomains = ["domain1.com", "domain2.com"]
    return globalConfiguration
}

func trackPage() {
    let tracker = TiaraTracker.getInstance(svcDomain: "svc.domain")
    tracker?.trackPage(name: "테스트", kind: nil, log: nil)
}

func flush() {
    print("flush")
    let tracker = TiaraTracker.getInstance(svcDomain: "svc.domain")
    tracker?.flush()
}
