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

var tracker : TiaraTracker? = nil


func initTiaraTracker() {
    TiaraTracker.initialize(configuration: configuration)
    var instanceConfiguration = TiaraInstanceConfiguration()
    instanceConfiguration.isDebugLoggerEnabled = true
    tracker = TiaraTracker.newInstance(svcDomain: "optimize.kakaocorp.com", configuration: instanceConfiguration)
}


var tuid: String {
    userDefaults?.string(forKey: "tuid") ?? ""
}

var configuration: TiaraGlobalConfiguration {
    var globalConfiguration = TiaraGlobalConfiguration()
    globalConfiguration.deployment = .sandbox
            globalConfiguration.sessionTimeout = 5
            globalConfiguration.cookieDomains = ["optimize.kakaocorp.com"]
    return globalConfiguration
}

func trackPage() {
    var log = TiaraLog(page: "테스트")
    log.setExperiment(experimentKey: "eatawtawt", variationKey: "rgaer", idType: .uuid)
    tracker?.trackPage(name: "테스트", kind: nil, log: log)
}

func flush() {
    print("flush")
    print(tracker)
    tracker?.flush()
}
