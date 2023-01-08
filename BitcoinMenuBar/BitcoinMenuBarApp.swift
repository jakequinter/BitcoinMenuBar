//
//  BitcoinMenuBarApp.swift
//  BitcoinMenuBar
//
//  Created by Jake Quinter on 1/8/23.
//

import SwiftUI

@main
struct BitcoinMenuBarApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
        } label: {
            Label("Bitcoin Price Checker", systemImage: "bitcoinsign.circle.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
