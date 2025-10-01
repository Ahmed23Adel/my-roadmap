//
//  CurrentTaskWidgetBundle.swift
//  CurrentTaskWidget
//
//  Created by ahmed on 30/09/2025.
//

import WidgetKit
import SwiftUI

@main
struct CurrentTaskWidgetBundle: WidgetBundle {
    var body: some Widget {
        CurrentTaskWidget()
        CurrentTaskWidgetControl()
        CurrentTaskWidgetLiveActivity()
    }
}
