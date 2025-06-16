//
//  TiaraUtils.swift
//  ab-lab-test
//
//  Created by jaddy on 6/4/25.
//

import Foundation
import TiaraSDK
import UIKit
import TiaraAB_SDK

let userDefaults = UserDefaults(suiteName: "com.kakao.tiaraSDK")
let experimentKey1 = "integration_test_1"
let experimentKey2 = "integration_test_2"
let experimentKey3 = "integration_test_3"

func initId() {
    DispatchQueue.main.async {
        print(userDefaults?.string(forKey: "tuid") ?? "없음")
        userDefaults?.removeObject(forKey: "tuid")
        exit(0)
    }

}

var tracker : TiaraTracker? = nil
var tiaraAB: TiaraAB? = nil
let serviceId = "9496"
let experimentKey = "monitoring"
let svcDomain = "optimize.kakaocorp.com"
let genderOptions = [("male", TiaraABTargetGender.male), ("female", TiaraABTargetGender.female)]
let ageOptions: Array<(String, TiaraABTargetAge)> = [("10s", .teenager), ("20s", .twenties), ("30s", .thirties), ("40s", .forties), ("50s", .fifties), ("60+", .sixtiesAndAbove), ("unknown", .unknown)]



func initTiaraTracker() {
    TiaraTracker.initialize(configuration: configuration)
    var instanceConfiguration = TiaraInstanceConfiguration()
    instanceConfiguration.isDebugLoggerEnabled = true
    tracker = TiaraTracker.newInstance(svcDomain: svcDomain, configuration: instanceConfiguration)
}

func initTiaraABFactory() {
    let config = TiaraABFactoryConfig.Builder()
        .set(errorHandler: NoOpErrorHandler())
        .set(isRunning: true)
        .set(isUpdateConfigImmediately: true)
        .set(isOnPolling: true)
        .set(pollingIntervalSeconds: TimeInterval(15 * 60))
        .build(serviceId: serviceId, deploy: Deploy.sandbox)
    
    tiaraAB = TiaraABFactory.syncGetNewInstance(config: config)
}

func getVariation(experimentKey: String, gender: TiaraABTargetGender = .unknown, age: TiaraABTargetAge = .unknown, custom: (String, String)? = nil) -> Variation? {
    let customMap = custom != nil ? [custom!.0: custom!.1] : [:]
    let attribute = TiaraABUserAttribute(userId: tuid, idType: .uuid, targetGender: gender, targetAge: age, targetCustom: customMap)
    return tiaraAB?.activate(experimentKey: experimentKey, tiaraABUserAttribute: attribute)
}


var tuid: String {
    get {
        return userDefaults?.string(forKey: "tuid") ?? ""
    }
    
}

var configuration: TiaraGlobalConfiguration {
    var globalConfiguration = TiaraGlobalConfiguration()
    globalConfiguration.deployment = .sandbox
            globalConfiguration.sessionTimeout = 5
            globalConfiguration.cookieDomains = [svcDomain]
    return globalConfiguration
}

func staticTrackPage() {
    var log = TiaraLog(page: "테스트")
    log.setExperiment(experimentKey: experimentKey, variationKey: "trest", idType: .uuid)
    tracker?.trackPage(name: "테스트", kind: nil, log: log)
}

func trackPageWithAB(experimentKey: String, variationKey: String) {
    var log = TiaraLog(page: "테스트")
    log.setExperiment(experimentKey: experimentKey, variationKey: variationKey, idType: .uuid)
    tracker?.trackPage(name: "테스트_페이지뷰", kind: nil, log: log)
}

func trackEvent() {
    let log = TiaraLog(page: "테스트")
    tracker?.trackEvent(name: "테스트_클릭", kind: nil, log: log)
}

func getVariation(experimentKey _: String) {
    
}

func flush() {
    tracker?.flush()
}
