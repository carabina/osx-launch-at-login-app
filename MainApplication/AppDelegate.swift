//
//  AppDelegate.swift
//  MainApplication
//
//  Created by Tibor Bodecs on 2015. 09. 17..
//  Copyright © 2015. Tibor Bodecs. All rights reserved.
//

import Cocoa
import ServiceManagement


extension Notification.Name {
    static let killme = Notification.Name("killme")
}



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		let launcherAppIdentifier = "com.tiborbodecs.LauncherApplication"

		//you should move this next line to somewhere else this is for testing purposes only!!!
		SMLoginItemSetEnabled(launcherAppIdentifier as CFString, true)
		
		var startedAtLogin = false
		for app in NSWorkspace.shared().runningApplications {
			if app.bundleIdentifier == launcherAppIdentifier {
				startedAtLogin = true
			}
		}

		if startedAtLogin {
			DistributedNotificationCenter.default().post(name: .killme, object: Bundle.main.bundleIdentifier!)
//			NSLog("i killed the launcher app!")
		}
	}
	
}

