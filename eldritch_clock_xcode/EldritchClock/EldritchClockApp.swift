//
//  EldritchClockApp.swift
//  EldritchClock
//
//  Created by Ashley McLemore on 12/24/22.
//

import SwiftUI

// A mix of code from SO posts -- makes window + (min,max,close buttons) transparent
// NSApplication: controls whole app (windows, events, etc.)
//   .shared: create instance of NSApplication9
//   .windows: array of NSWindow objects
//   delegate: customize app without making subclass of NSApplication
// applicationDidFinishLaunching: tells delegate that app has started and needs its first event
//
final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.isOpaque = false
            window.backgroundColor = NSColor.clear
            window.isMovableByWindowBackground = true
            window.standardWindowButton(NSWindow.ButtonType.closeButton)?.isHidden = true
            window.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(NSWindow.ButtonType.zoomButton)?.isHidden = true
        }
    }
}


@main
struct EldritchClockApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate // need this to connect to code above
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
