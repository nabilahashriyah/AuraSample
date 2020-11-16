//
//  TimerView.swift
//  Aura
//
//  Created by Hubert Daryanto on 06/10/20.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var firstAidStatus: CaseSwitcher
    @ObservedObject var stopwatchManager: StopwatchManager
    var body: some View {
            if stopwatchManager.secondsElapsed < 300
            {
                TV_normal(firstAidStatus: firstAidStatus, stopwatchManager: stopwatchManager)
            }
            else
            {
                TV_big(firstAidStatus: firstAidStatus, stopwatchManager: stopwatchManager)
            }
    }
}
