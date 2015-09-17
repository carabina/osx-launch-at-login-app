//
//  AppDelegate.swift
//  MainApplication
//
//  Created by Tibor Bodecs on 2015. 09. 17..
//  Copyright © 2015. Tibor Bodecs. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		let launcherAppIdentifier = "com.tiborbodecs.LauncherApplication"

		//you should move this next line to somewhere else this is for testing purposes only!!!
		SMLoginItemSetEnabled(launcherAppIdentifier, true)
		
		var startedAtLogin = false
		for app in NSWorkspace.sharedWorkspace().runningApplications {
			if app.bundleIdentifier == launcherAppIdentifier {
				startedAtLogin = true
			}
		}

		if startedAtLogin {
			NSDistributedNotificationCenter.defaultCenter().postNotificationName("killme", object: NSBundle.mainBundle().bundleIdentifier!)
//			NSLog("i killed the launcher app!")
		}
	}
	
}

