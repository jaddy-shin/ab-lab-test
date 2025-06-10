//
//  ContentView.swift
//  ab-lab-test
//
//  Created by jaddy on 6/4/25.
//

import SwiftUI
import TiaraSDK
import TiaraAB_SDK

struct ContentView: View {
    @State var tuid: String = userDefaults?.string(forKey: "tuid") ?? "없음"
    @State var variation1: String = getVariation(experimentKey: experimentKey1)?.key ?? "없음"
    @State var variation2: String = getVariation(experimentKey: experimentKey2)?.key ?? "없음"
    @State var variation3: String = getVariation(experimentKey: experimentKey3)?.key ?? "없음"
    
    @State var experiment2SelectedGender: TiaraABTargetGender = .female
    @State var experiment2SelectedAge: TiaraABTargetAge = .teenager
    @State var experiment2SelectedCustom: String = "test4"
    let experiment2CustomOptions: [(String, String)] = [("포함1", "test1"), ("포함2", "test2"), ("포함3", "test3"), ("포함하지 않음", "test4")]
    
    @State var experiment3SelectedGender: TiaraABTargetGender = .male
    @State var experiment3SelectedAge: TiaraABTargetAge = .sixtiesAndAbove
    @State var experiment3SelectedCustom: String = "3"
    let experiment3CustomOptions: [(String, String)] = [("5-포함안함", "5"), ("6-포함", "6"), ("문자", "test3"), ("7-포함", "7")]
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("설정 정보").font(.title)
                        .padding(.bottom)
                    HStack {
                        Text("Tuid")
                            .bold()
                        Text(tuid)
                    }
                    .padding()
                    Button(action: {
                        initId()
                    }) {
                        Text("id 초기화 후 종료")
                    }
                    .padding()
                    Button(action: {
                        flush()
                    }) {
                        Text("flush")
                    }
                }
                Spacer()
                VStack {
                    Text("실험 공통")
                        .frame( alignment: .top)
                        .font(.headline)
                        .padding()
                    Button(action: {
                        staticTrackPage()
                    }) {
                        Text("static 로그 전송")
                    }
                    .padding()
                    Button(action: {
                        trackEvent()
                    }) {
                        Text("지표 측정 event 로그 전송")
                    }
                }
                Spacer()
                VStack {
                    Text("시나리오 1번")
                        .frame( alignment: .top)
                        .font(.headline)
                    HStack {
                        Text("variation")
                            .bold()
                        Spacer()
                        Text(variation1)
                    }
                    Button(action: {
                        variation1 = getVariation(experimentKey: experimentKey1)?.key ?? "없음"
                    }) {
                        Text("variation 새로고침")
                    }
                    Button(action: {
                        trackPageWithAB(experimentKey: experimentKey1, variationKey: variation1)
                    }) {
                        Text("Variation 페이지뷰 전송")
                    }
                }
                Spacer()
                VStack {
                    Text("시나리오 2번")
                        .frame( alignment: .top)
                        .font(.headline)
                    Picker("성별", selection: $experiment2SelectedGender) {
                        ForEach(genderOptions, id: \.1) {
                            Text($0.0).tag($0.1)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("연령대", selection: $experiment2SelectedAge) {
                        ForEach(ageOptions, id: \.1) {
                            Text($0.0).tag($0.1)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("커스텀", selection: $experiment2SelectedCustom) {
                        ForEach(experiment2CustomOptions, id: \.1) {
                            Text($0.0).tag($0.1)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    HStack {
                        Text("variation")
                            .bold()
                        Spacer()
                        Text(variation2)
                    }
                    Button(action: {
                        variation2 = getVariation(experimentKey: experimentKey3, gender: experiment2SelectedGender, age: experiment2SelectedAge, custom: ("test", experiment2SelectedCustom))?.key ?? "없음"
                    }) {
                        Text("variation 새로고침")
                    }
                    Button(action: {
                        trackPageWithAB(experimentKey: experimentKey2, variationKey: variation2)
                    }) {
                        Text("Variation 페이지뷰 전송")
                    }
                }
                Spacer()
                VStack {
                    Text("시나리오 3번")
                        .frame( alignment: .top)
                        .font(.headline)
                    Picker("성별", selection: $experiment3SelectedGender) {
                        ForEach(genderOptions, id: \.1) {
                            Text($0.0).tag($0.1)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("연령대", selection: $experiment3SelectedAge) {
                        ForEach(ageOptions, id: \.1) {
                            Text($0.0).tag($0.1)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("커스텀", selection: $experiment3SelectedCustom) {
                        ForEach(experiment3CustomOptions, id: \.1) {
                            Text($0.0).tag($0.1)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    HStack {
                        Text("variation")
                            .bold()
                        Spacer()
                        Text(variation3)
                    }
                    Button(action: {
                        variation3 = getVariation(experimentKey: experimentKey3, gender: experiment3SelectedGender, age: experiment3SelectedAge, custom: ("test", experiment3SelectedCustom))?.key ?? "없음"
                    }) {
                        Text("variation 새로고침")
                    }
                    Button(action: {
                        trackPageWithAB(experimentKey: experimentKey3, variationKey: variation3)
                    }) {
                        Text("Variation 페이지뷰 전송")
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
